#! /usr/bin/env mzscheme
#lang scheme/base
(require scheme/cmdline)
(require scheme/list)

(define countdown 
  (lambda (n)  
    (cond ((zero? n) 'done) 
          (else (countdown (sub1 n))))))
(define usage 
  (lambda ()
    (fprintf (current-output-port) "usage: ~a -c <num> -t <threads>~n" (find-system-path 'run-file))))

(define ccount (make-parameter 0))
(define threads (make-parameter 0))

(define file-to-process
   (command-line
       #:once-each
         [("-c" "--count") c "Number to count down to"
                                               (ccount c)]
         [("-t" "--times") t "Number of threads to create"
                                               (threads t)]
         ))
;           #:args
;             (filename) filename))


(fprintf (current-output-port) "~a ~a.~n" (count) (threads))

; (define result  (for ([i (in-range (string->number (threads)))])
;       (thread (lambda () (countdown count)))))
(map thread-wait (build-list (string->number (threads)) (thread (lambda (x) (countdown count)))))


; (if (or (= (string->number (ccount)) 0) (= (string->number (threads)) 0))
;   (usage)
;   (
   ; fprintf (current-output-port) "~a ~a.~n" (ccount) (threads)
   ; (display '(make-list (string->number (threads)) (string->number (ccount))))
(map thread-wait
     (make-list (string->number (threads)) 
                (thread (lambda () (countdown (string->number (ccount)))))))
  
  ; ))


; (map (lambda (t) (thread-wait t))
;              (make-list (string->number (threads)) 
;                         (thread (lambda () (countdown (string->number (ccount)))))))
; (make-list 10 5) 
