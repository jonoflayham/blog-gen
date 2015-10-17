(ns blog-gen.rss
  (:require [clojure.data.xml :as xml]))

(defn- entry [post]
  [:entry
   [:title (:title post)]
   [:updated (:date post)]
   [:author [:name "Jon Woods"]]
   [:link {:href (str "http://jonoflayham.com" (:path post))}]
   [:id (str "urn:jonoflayham-io:feed:post:" (:title post))]
   [:content {:type "html"} (:content post)]])

(defn atom-xml [posts]
  (let [sorted-posts (->> posts (sort-by :date) reverse)]
    (xml/emit-str
     (xml/sexp-as-element
      [:feed {:xmlns "http://www.w3.org/2005/Atom"}
       [:id "urn:jonoflayham-io:feed"]
       [:updated (-> posts first :date)]
       [:title {:type "text"} "Loose Typing"]
       [:link {:rel "self" :href "http://jonoflayham.com/atom.xml"}]
       (map entry posts)]))))