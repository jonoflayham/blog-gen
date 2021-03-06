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

Build and publish site, having committed and pushed changes:

    # ./build-and-push-site.sh