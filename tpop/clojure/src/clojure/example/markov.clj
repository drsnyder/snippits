(ns clojure.example.markov
  (:require clojure.contrib.duck-streams)
  (:require clojure.contrib.seq-utils)
  (:gen-class))

; for repl
;(use 'clojure.contrib.seq-utils)
;(use 'clojure.contrib.duck-streams)
;(import java.util.Random) 
;
;(def *rand* (new Random))

(def *nonword* "\n")

(defn tokenize[line]
  (vec (.split line " ")))

(defn prefix[one & rest]
  (reduce #(conj %1 %2) (vector one) rest))

 
(defn prefix-pos-n[prefix n]
  (get prefix n))

(defn prefix-hash[prefix]
  (reduce #(str %1 "" %2) prefix))

(defn prefix-add[prefix toadd]
  (conj (subvec prefix 1) toadd))

(defn prefix-equal?[one two]
  (if (= (count one) (count two))
    (reduce #(and %1 %2) true (map = one two))
    false))

(defn chain-add[table prefix word]
    (if (contains? table (prefix-hash prefix))
      (update-in table [(prefix-hash prefix)] conj word)
      (assoc table (prefix-hash prefix) (vector word))))
  
(defn random-chain-word[table prefix]
  (let [wordlist (get table (prefix-hash prefix))]
    (do 
      ;(println (str "r-c-w " wordlist "~" prefix))
      (get wordlist (rand-int (count wordlist)))
      )))

(defn chain-build[table prefix words]
    (if (not (empty? words))
      (recur (chain-add table prefix (first words)) 
             (prefix-add prefix (first words)) 
             (rest words))
      ; add the end marker 
      (chain-add table prefix *nonword*)))

(defn file-to-words[file]
  (vec (clojure.contrib.seq-utils/flatten 
    (reduce 
      #(conj %1 (tokenize %2)) 
      [] (clojure.contrib.duck-streams/read-lines file)))))

(defn generate[table nwords]
  (loop [i 1 prefix (prefix *nonword* *nonword*)]
    (let [suf (random-chain-word table prefix)]
      (when 
        (and (< i nwords) (not= suf *nonword*) (not= suf nil))
          (if (= (rem i 5) 0)
            (println suf)
            (print (str suf " ")))
          (recur (inc i) (prefix-add prefix suf))))))

;(def words (file-to-words "/Users/drsnyder/tmp/bib1910.txt")) 
;(def table (chain-build {} (prefix "\n" "\n") (take 100 words)))
;
;(def words (file-to-words "/Users/drsnyder/playground/snippits/tpop/clojure/t/data/markov-1.txt")) 
;(def table (chain-build {} (prefix "\n" "\n") words))
;
;(def words (file-to-words "/Users/drsnyder/playground/snippits/tpop/clojure/t/data/markov-2.txt")) 
;(def table (chain-build {} (prefix "\n" "\n") words))
;(generate table 1000)

(defn -main[file nwords]
  (def words (file-to-words file)) 
  (def table (chain-build {} (prefix "\n" "\n") words))
  (generate table (Integer. nwords)))
