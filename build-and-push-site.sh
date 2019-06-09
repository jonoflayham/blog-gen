#!/bin/bash -eu

# Clones existing built site, builds new version into clone, and commits it
# to built site repo, identifying the generating site's commit.  Assumes
# generating site content is fully committed, ie 'git status' would show
# nothing.
generatorCommitHash=`git rev-parse HEAD`

echo "Clone existing repo for the built site"
rm -rf dist
BLOG_REPO_URL=git@github.com:jonoflayham/jonoflayham.github.io.git
git clone $BLOG_REPO_URL dist

echo "Build site and so mutate existing site content"
lein run -m blog-gen.web/export dist

echo "Add, commit and push changes to the repo for the built site"

cd dist
git add --all
git config user.email "jonoflayham@gmail.com"
git config user.name "Jon Woods"
git commit -m "Site generated from https://github.com/jonoflayham/blog-gen/commit/$generatorCommitHash"
git push $BLOG_REPO_URL master