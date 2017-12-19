(defproject blog-gen "0.1.0-SNAPSHOT"
  :description "Source code and content for jonoflayham.com.  Code derived from https://github.com/gilbertw1/blog-gen, and comprehended with the help of https://github.com/cjohansen/cjohansen-no/blob/master/resources/md/building-static-sites-in-clojure-with-stasis.md, with thanks to the authors of both."
  :url "http://jonoflayham.com"
  :license {:name "BSD 2 Clause"
            :url  "http://opensource.org/licenses/BSD-2-Clause"}
  :dependencies [[org.clojure/clojure "1.9.0"]
                 [stasis "2.3.0"]
                 [ring "1.6.3"]
                 [hiccup "1.0.5"]
                 [me.raynes/cegdown "0.1.1"]
                 [enlive "1.1.6"]
                 [clygments "1.0.0"]
                 [optimus "0.20.1"]
                 [clj-time "0.14.2"]
                 [org.clojure/data.xml "0.0.8"]]
  :ring {:handler blog-gen.web/app}
  :aliases {"build-site" ["run" "-m" "blog-gen.web/export"]}
  :profiles {:dev {:dependencies [[midje "1.9.1" :exclusions [org.clojure/clojure]]]
                   :plugins      [[lein-ring "0.12.2"]
                                  [lein-midje "3.2"]
                                  [lein-ancient "0.6.15"]]}})
