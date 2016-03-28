#!/bin/bash -eu

echo "Executing Midje tests"
lein midje

if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
    echo "Travis pull request, so only building site, not pushing it"
    lein run -m blog-gen.web/export
    exit 0
fi

generatorCommitHash=`git rev-parse HEAD`

echo "Cloning existing repo for the built site"
rm -rf dist
git clone https://${GH_TOKEN}@github.com/jonoflayham/jonoflayham.github.io.git dist

echo "Building site and so mutating existing site content"
lein run -m blog-gen.web/export dist

echo "Adding, committing and pushing changes to the repo for the built site"

cd dist
git add --all
git config user.email "jonoflayham@gmail.com"
git config user.name "Jon Woods"
git config --global push.default simple
git commit -m "Site generated from https://github.com/jonoflayham/blog-gen/commit/$generatorCommitHash"
git push https://${GH_TOKEN}@github.com/jonoflayham/jonoflayham.github.io.git
