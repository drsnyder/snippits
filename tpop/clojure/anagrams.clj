
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


(defn firstn[seq n]
  (drop-last (- (count seq) n) seq))


(defn anagram-add[anagrams akey word]
  (if (empty? (get anagrams akey))
    (assoc anagrams akey (hash-map :count 1, :words (list word)))
    (update-in (update-in anagams akey [:count] inc) [:words] conj word)))

(defn build-anagrams[seq]
  (loop [left seq word (first left) akey (str-sort (str-to-lower word)) anagrams {}]
    (if (empty? left)
      anagrams
      (do 
        (anagram-add anagrams akey word)
        (recur (rest left))))))


(def words (f-to-seq "/usr/share/dict/web2"))
(def anagrams #{})
(count (f-to-seq "/usr/share/dict/web2"))
