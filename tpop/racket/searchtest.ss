#!/usr/bin/env mzscheme
#lang scheme/base 
(require (planet schematics/schemeunit:3:4))
(require "search.ss")
; (define v (load-wordfile "/Users/drsnyder/playground/snippits/tpop/racket/web2"))
; (vector-quicksort! v wordvector-compare?)

(define gen-random-real-vector
  (lambda (n)

    (define gen-vector
      (lambda (n c l)
        (if (>= c n) l
          (gen-vector n (+ c 1) (cons (* 100 (random)) l)))))

    (list->vector (gen-vector n 0 '()))))


(define elem 100)

(test-case
  "Sorting a list of ramdom numbers."
    (define rv (gen-random-real-vector elem))
    (vector-quicksort! rv (lambda (a b) (< a b)))

    (do ((i 1 (+ i 1)))
      ((= i elem)) 
       
      (fprintf (current-output-port) "> ~s ~s~n" 
               (vector-ref rv i) 
               (vector-ref rv (- i 1)))
       (check > (vector-ref rv i) (vector-ref rv (- i 1))))
    )

; (check-equal? 2 2 "Simple addition")
; (check-equal? 1 2 "Simple multiplication")
