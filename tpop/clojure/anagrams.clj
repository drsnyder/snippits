
;(use 'clojure.test')

(println "hello")

(defn f-to-seq[file]
  (with-open [rdr (java.io.BufferedReader. 
                    (java.io.FileReader. file))]
    (doall (line-seq rdr))))

(defn str-sort[str]
  (String. (into-array (. Character TYPE) (sort str))))

(defn str-to-lower[str]
  (.toLowerCase str))

(count (f-to-seq "/usr/share/dict/web2"))
