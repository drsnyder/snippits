(ns clojure.example.hello
      (:gen-class))
 
(defn -main
    [greetee]
    (println (str "Hello " greetee "!")))
