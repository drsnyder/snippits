
(use 'clj-ssh.ssh)
(use 'clojure.contrib.logging)

(import [com.jcraft.jsch JSch])

(def ^{:dynamic true} *ssh-log-levels*
  {com.jcraft.jsch.Logger/DEBUG :debug
   com.jcraft.jsch.Logger/INFO  :info
   com.jcraft.jsch.Logger/WARN  :warn
   com.jcraft.jsch.Logger/ERROR :error
   com.jcraft.jsch.Logger/FATAL :fatal})

(deftype SshLogger
         [log-level]
         com.jcraft.jsch.Logger
         (isEnabled
           [_ level]
           (>= level log-level))
         (log
           [_ level message]
           (clojure.contrib.logging/log (*ssh-log-levels* level) message nil "clj-ssh.ssh")))

(JSch/setLogger (SshLogger. com.jcraft.jsch.Logger/FATAL))

(defn hash-flip [ht]
  (reduce #(assoc %1 (ht %2) %2) {} (keys ht)))

(defn set-ssh-log-level! [level]
  (JSch/setLogger (SshLogger. ((hash-flip *ssh-log-levels*) level))))

(set-ssh-log-level! :error)

(with-ssh-agent [false]
  (add-identity "/home/drsnyder/.ssh/id_dsa")
  (let [session (session "localhost" :strict-host-key-checking :no)]
    (with-connection session
      ;(let [result (ssh session :in "echo hello" :result-map true)]
      ;  (println result))
      (let [result (ssh session "/bin/bash" "-c" "ls" "/")]
        (println (second result))))))

(defn send-commands [host commands &key id]
  (with-ssh-agent [false]
    (if (not (nil? id)) (add-identity id))
    (let [session (session host :strict-host-key-checking :no)]
      (with-connection session
         (loop [cmds commands results []]
           (if (nil? (first cmds)) 
             results
             (recur (rest cmds) (conj results (second (ssh session (first cmds)))))))))))

(defn send-command [host command &key id]
  (send-commands host command :id id))

(send-commands "rudy.huddler.com" ["ls" "hostname"] :id "/Users/drsnyder/.ssh/id_rsa")
(send-command "rudy.huddler.com" ["hostname"] :id "/Users/drsnyder/.ssh/id_rsa")
