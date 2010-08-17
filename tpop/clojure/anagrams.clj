
;(use 'clojure.test')

(defn f-to-seq[file]
  (with-open [rdr (java.io.BufferedReader. 
                    (java.io.FileReader. file))]
    (doall (line-seq rdr))))

(defn str-sort[str]
  (if (nil? str)
    str
  (String. (into-array (. Character TYPE) (sort str)))))

(defn str-to-lower[str]
  (if (nil? str)
    str
    (.toLowerCase str)))


(defn anagram-add[anagrams akey word]
  (if (empty? (get anagrams akey))
    (assoc anagrams akey (hash-map :count 1, :words (list word)))
    (update-in (update-in anagrams [akey :count] inc) [akey :words] conj word)))

(defn word[seq] (first seq))

(defn build-anagrams[seq]
  (loop [seq seq 
         akey (str-sort (str-to-lower (word seq))) 
         anagrams {}]
    (if (empty? seq)
      anagrams
      (recur (rest seq) 
             (str-sort (str-to-lower (word (rest seq)))) 
             (anagram-add anagrams akey (word seq))))))


(defn print-anagram[v]
  (println (str (:count (first (rest v))) " " (first v) ": " (:words (first (rest v))))))

(defn print-anagrams[ana]
  (doseq [v ana] 
    (print-anagram v)))

(defn anagram-key[elem] (:count (first (rest elem)))) 

(def *words* (f-to-seq "/usr/share/dict/web2"))
(def *anagrams* (sort-by anagram-key (build-anagrams *words*)))
(print-anagrams (take 10 (reverse *anagrams*)))

;(build-anagrams (take 5 words))
;(count (f-to-seq "/usr/share/dict/web2"))
