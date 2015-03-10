(ns blog-gen.file
  (:import (java.io File)))

(defn- clean-export-dir! [ dir level]
  (doseq [file (.listFiles dir)]
    (cond
      (.isFile file) (.delete file)
      (or (> level 0) (not= ".git" (.getName file))) (do
                                                       (clean-export-dir! file (inc level))
                                                       (.delete file)))))

(defn clean-export-area!
  "Cleans export directory by deleting everything in it except a .git folder at the root"
  [^String export-dir]
  (clean-export-dir! (File. export-dir) 0))