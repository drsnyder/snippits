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


;;;;
(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (slow* a b)
  (if (= b 0)
    0
    (+ a (slow* a (- b 1)))))
;;;

(define (double x) (+ x x))
(define (halve x) (/ x 2))

(define (fast* a b)
  (cond
    ((= b 0) 0)
    ((even? b) (+ (double (fast* a (halve b)))))
    (else (+ a (fast* a (- b 1))))))

