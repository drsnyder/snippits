(define (square n) (* n n))

(define (my-expt b n) 
  (expt-iter-fast 1 b n))

; breaks on n not a power of 2
(define (expt-iter-fast a b n)
  (cond 
    ((= n 1) a)
    ((= 1 a) (expt-iter-fast (* a (square b))
                                b
                                (/ n 2)))
    (else (expt-iter-fast (square a) 
                          b 
                          (/ n 2)))))

