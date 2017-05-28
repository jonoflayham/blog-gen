Blog generator for jonoflayham.github.io
========================================

[![Build Status](https://travis-ci.org/jonoflayham/blog-gen.svg?branch=master)](https://travis-ci.org/jonoflayham/blog-gen)

This repo contains a static blog site generator, and blog content, for [jonoflayham.github.io](http://jonoflayham.github.io), which is driven from [jonoflayham/jonoflayham.github.io.git](https://github.com/jonoflayham/jonoflayham.github.io) and aliased to [jonoflayham.com](http://jonoflayham.com).

With thanks to those involved, code (but not content within `resources/posts`) is based on [https://github.com/gilbertw1/blog-gen](https://github.com/gilbertw1/blog-gen), which is in turn derived from [stasis](https://github.com/magnars/stasis) and [an excellent stasis tutorial](http://cjohansen.no/building-static-sites-in-clojure-with-stasis).

Running
-------

Serve the site locally:

    $ lein ring server

Build the site, exporting to /dist:

    $ lein build-site

Travis config
-------------

Cf https://gist.github.com/domenic/ec8b0fc8ab45f39403dd for guidance.

In summary:

- generate a key pair and give GitHub the public key as a deploy key for the blog site

- ask Travis to encrypt the private key, storing the result and the initialisation vector (IV) used, with `travis encrypt-file deploy_key`

- decrypt the deploy key during the Travis build, using Travis's environment retrieval mechanism to find the encrypted version and the IV used, and use the decrypted private deploy key to push blog site changes to GitHub
