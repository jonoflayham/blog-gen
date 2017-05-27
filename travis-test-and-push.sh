#!/bin/bash -eu

echo "Execute Midje tests"
lein midje

if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
    echo "Travis pull request, so only building site, not pushing it"
    lein run -m blog-gen.web/export
    exit 0
fi

generatorCommitHash=`git rev-parse HEAD`

echo "Add decrypted deploy key to ssh-agent"
# ENCRYPTION_LABEL variable is defined via .travis.yml.
DECRYPTION_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
DECRYPTION_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
DECRYPTION_KEY=${!DECRYPTION_KEY_VAR}
DECRYPTION_IV=${!DECRYPTION_IV_VAR}
openssl aes-256-cbc -K $DECRYPTION_KEY -iv $DECRYPTION_IV -in xyz -out abc -d
chmod 600 abc
eval `ssh-agent -s`
ssh-add abc
rm abc

echo "Clone existing repo for the built site"
rm -rf dist
git clone git@github.com:jonoflayham/blog-gen.git dist

echo "Build site and so mutating existing site content"
lein run -m blog-gen.web/export dist

echo "Add, commit and push changes to the repo for the built site"

cd dist
git add --all
git config user.email "jonoflayham@gmail.com"
git config user.name "Jon Woods"
git commit -m "Site generated from https://github.com/jonoflayham/blog-gen/commit/$generatorCommitHash"
git push git@github.com:jonoflayham/jonoflayham.github.io.git master