(ns clojure.example.anagrams
  (:require clojure.contrib.profile)
  (:require clojure.contrib.duck-streams)
  (:gen-class))
 
(defn str-sort[string]
  (when string
    (apply str (sort string))))


(defn str-to-lower[string]
  (when string
    (.toLowerCase string)))


(defn anagram-add[anagrams akey word]
  (if (contains? anagrams akey)
    (-> anagrams
      (update-in [akey :count] inc)
      (update-in [akey :words] conj word))
    (assoc anagrams akey {:count 1 :words [word]})))

(def normalise (comp str-to-lower str-sort))

(defn build-anagrams[words]
  (reduce #(anagram-add %1 (normalise %2) %2) {} words))


(defn print-anagram[v] 
  (println (str (:count (second v)) " " (first v) ": " (:words (second v))))) 

(defn print-anagrams[ana] 
    (doseq [v ana] 
          (print-anagram v))) 

(defn anagram-key[elem] 
    (- (:count (second elem)))) 


;(def *words* (f-to-seq "/usr/share/dict/web2")) 
;(def *anagrams* (sort-by anagram-key (build-anagrams *words*)))
;(print-anagrams (take 10 *anagrams*)) 

(defn -main[file]
  (time (print-anagrams 
          (take 10 
                (sort-by anagram-key 
                         (build-anagrams 
                           (clojure.contrib.duck-streams/read-lines file)))))))
