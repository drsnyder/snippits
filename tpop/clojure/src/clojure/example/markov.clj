(ns clojure.example.markov
  (:require clojure.contrib.duck-streams)
  (:require clojure.contrib.seq-utils)
  (:gen-class))

; for repl
(use 'clojure.contrib.seq-utils)
(use 'clojure.contrib.duck-streams)
(import java.util.Random) 
(def *rand* (new Random))



(defn prefix[one & rest]
  (reduce #(conj %1 %2) (vector one) rest))
 
(defn prefix-pos-n[prefix n]
  (get prefix n))

(defn prefix-hash[prefix]
  (reduce #(str %1 "" %2) prefix))

(defn prefix-add[prefix toadd]
  (conj (rest prefix) toadd))

(defn prefix-equal?[one two]
  (if (= (count one) (count two))
    (reduce #(and %1 %2) true (map = one two))
    false))

(defn chain-add[table prefix word]
    (if (contains? table prefix)
      (update-in table (prefix-hash prefix) conj word)
      (assoc table (prefix-hash prefix) (vector word))))
  
(defn random-chain-word[table prefix]
  (let [wordlist (get table (prefix-hash prefix))]
    (get wordlist (rem (. Math abs (. *rand* nextInt)) (count wordlist)))))

(defn chain-build[table prefix words]
  (do 
    (println (str "table " table))
    (println (str "prefix " prefix))
    (println (str "words " words))

    (if (not (empty? words))
      (recur (chain-add table prefix (first words)) 
             (prefix-add prefix (first words)) 
             (rest words))
      table)))

(defn line-to-words[line]
  (doall (re-seq #"\w+" line)))

(defn file-to-words[file]
  (clojure.contrib.seq-utils/flatten 
    (reduce 
      #(conj %1 (line-to-words %2)) 
      () (clojure.contrib.duck-streams/read-lines file))))


(def words (file-to-words "/Users/drsnyder/tmp/bib1910.txt")) 
(chain-build {} (prefix "\n" "\n") (take 5 words))


(defn -main[file]
  (time (print-anagrams 
          (take 10 
                (sort-by anagram-key 
                         (build-anagrams 
                           (clojure.contrib.duck-streams/read-lines file)))))))
