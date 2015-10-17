jonoflayham.github.io
=====================

[![Build Status](https://travis-ci.org/jonoflayham/blog-gen.svg?branch=master)](https://travis-ci.org/jonoflayham/blog-gen)

Static blog site generator for [jonoflayham.com](http://jonoflayham.com).

With thanks to those involved, code (but not content within `resources/posts`) is based on [https://github.com/gilbertw1/blog-gen](https://github.com/gilbertw1/blog-gen), which is in turn derived from [stasis](https://github.com/magnars/stasis) and [an excellent stasis tutorial](http://cjohansen.no/building-static-sites-in-clojure-with-stasis).

Running
-------

Local Server

    $ lein ring server

Build Site (exports to dist/)

    $ lein build-site