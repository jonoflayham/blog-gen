(defproject blog-gen "0.1.0-SNAPSHOT"
  :description "Source code and content for jonoflayham.com.  Code derived from https://github.com/gilbertw1/blog-gen, and comprehended with the help of https://github.com/cjohansen/cjohansen-no/blob/master/resources/md/building-static-sites-in-clojure-with-stasis.md, with thanks to the authors of both."
  :url "http://jonoflayham.com"
  :license {:name "BSD 2 Clause"
            :url  "http://opensource.org/licenses/BSD-2-Clause"}
  :dependencies [[org.clojure/clojure "1.10.3"]
                 [stasis "2.5.1"]
                 [ring "1.9.3"]
                 [hiccup "1.0.5"]
                 [me.raynes/cegdown "0.1.1"]
                 [enlive "1.1.6"]
                 [clygments "2.0.2"]
                 [optimus "0.20.2"]
                 [clj-time "0.15.2"]
                 [org.clojure/data.xml "0.0.8"]]
  :ring {:handler blog-gen.web/app}
  :aliases {"build-site" ["run" "-m" "blog-gen.web/export"]}
  :profiles {:dev {:dependencies [[midje "1.10.3" :exclusions [org.clojure/clojure]]]
                   :plugins      [[lein-ring "0.12.5"]
                                  [lein-midje "3.2.1"]
                                  [lein-ancient "1.0.0-RC3"]]}})
