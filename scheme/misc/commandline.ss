#! /usr/bin/env mzscheme
#lang scheme/base
(require scheme/cmdline)

(define countdown 
  (lambda (n)  
    (cond ((zero? n) 'done) 
          (else (countdown (sub1 n))))))


(define count (make-parameter 0))
(define threads (make-parameter 0))

(define file-to-process
   (command-line
       #:once-each
         [("-c" "--count") c "Number to count down to"
                                               (count c)]
         [("-t" "--times") t "Number of threads to create"
                                               (threads t)]
         ))
;           #:args
;             (filename) filename))


(fprintf (current-output-port) "~a ~a.~n" (count) (threads))

; (define result  (for ([i (in-range (string->number (threads)))])
;       (thread (lambda () (countdown count)))))
(map thread-wait (build-list (string->number (threads)) (thread (lambda (x) (countdown count)))))

