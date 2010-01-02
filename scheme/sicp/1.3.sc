
(define (sum-squares a b) (+ (square a) (square b)))

(define (sum-squares-max a b c)
  (if (a > b)
    (if (b > c)
      (sum-squares a b)
      (sum-squares a c))
    (if (a > c)
      (sum-squares b a)
      (sum-squares b c))
    ))


;(sum-squares 3 4)
; need a max fn here i think
(sum-squares-max 4 3 5)

