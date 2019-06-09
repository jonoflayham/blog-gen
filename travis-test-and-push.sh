#!/bin/bash -eu

echo "Execute Midje tests on generator"
lein midje

if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
    echo "Travis pull request, so only building site, not pushing it"
    lein run -m blog-gen.web/export dist
    exit 0
fi

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

./build-and-push-site.sh