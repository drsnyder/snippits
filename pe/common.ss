#lang scheme
(define factor?
  (lambda (num factor)
    (eq? (modulo num factor) 0)))
