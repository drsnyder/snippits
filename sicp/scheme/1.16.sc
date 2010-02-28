(define (square n) (* n n))

(define (my-expt b n) 
  (cond
    ((= n 0) 1)
    (else (expt-iterf b b n))))

(define (even? n)
    (= (remainder (truncate n) 2) 0))

(define (expt-iterf a b n)
  (cond
    ((= n 1) a)
    ((even? n) (expt-iterf (square a)
                           b
                           (/ n 2)))
    (else (* a (expt-iterf (square a)
                      b
                      (/ (- n 1) 2))))))

