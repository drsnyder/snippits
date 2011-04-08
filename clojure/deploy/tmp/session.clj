
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



(defn send-commands [host commands & {:keys [id] :or {id nil}} ]
  (with-ssh-agent [false]
    (if (not (nil? id)) (add-identity id) (add-identity (default-identity)))
    (let [session (session host :strict-host-key-checking :no)]
      (with-connection session
         (loop [cmds commands results []]
           (if (nil? (first cmds)) 
             results
             (recur (rest cmds) (conj results (second (ssh session (first cmds)))))))))))

(defn send-command [host command & {:keys [id] :or {id nil}} ]
  (send-commands host [command] :id id))

(send-commands "rudy.huddler.com" ["ls" "hostname"] :id "/Users/drsnyder/.ssh/id_dsa")
(send-commands "rudy.huddler.com" ["ls" "hostname"])
(send-command "rudy.huddler.com" "hostname" :id "/Users/drsnyder/.ssh/id_rsa")

;(with-role web-app
;           (deploy-code args)
;           (run "some command")
;           (link-code args)
;           (purge-cache args)
;           (run "some other command"))

(def *role* nil)

(def web {:hosts ["rudy.huddler.com", "newdy.huddler.com"]})

(defmacro with-role
  ([role-binding & body]
   `(binding [*role* ~role-binding]
      (do ~@body))))

(defn run [cmd]
  (loop [hosts (*role* :hosts)]
    (let [host (first hosts)]
      (when (not (nil? host))
        (do (println (str "=> " (send-command host cmd)))
          (recur (rest hosts)))))))

(defn deploy-code [] ; :filter => somefunk, :only, :except
  (println (format "binding *role* is %s" (str *role*))))

(with-role web
           (run "hostname"))

(with-role {:hosts ["rudy.huddler.com"]}
           (deploy-code))

(ssh "rudy.huddler.com" "hostname")
