; vim: ft=scheme
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (sqrt-iter guess x change)
  (if (good-enough? guess x change)
      guess
      (sqrt-iter (improve guess x) x (abs (- guess (improve guess x))))
      )
  )

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x change)
  (< (/ change guess) 0.00000001))

(define (sqrt x)
  (sqrt-iter 1.0 x x))




(sqrt 3)
(sqrt 9)
(sqrt 4294967296)
(sqrt (+ 1099511627776 5))
(sqrt 0.002)
