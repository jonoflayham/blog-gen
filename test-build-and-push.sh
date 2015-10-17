#!/bin/bash -eu

echo "Executing Midje tests"
lein midje

if [[ "$TRAVIS_PULL_REQUEST" != "false ]]; then
    echo "Travis pull request, so only building site, not pushing it"
    lein run -m blog-gen.web/export
    exit 0
fi

generatorCommitHash=`git rev-parse HEAD`

echo "Cloning existing site repo"
mkdir dist
cd dist
git clone https://${GH_TOKEN}@github.com/jonoflayham/jonoflayham.github.io.git

echo "Building site"
lein run -m blog-gen.web/export

echo "Adding, committing and pushing changes"
git config user.email ${GH_EMAIL}
git config user.name ${GH_NAME}
git add --all
git commit -m "Site generated from commit $generatorCommitHash"
git push https://${GH_TOKEN}@github.com/jonoflayham/jonoflayham.github.io.git