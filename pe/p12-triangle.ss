#lang scheme
(define divisors
  (lambda (n)
    (let f ([i 1])
      (cond
        [(> i n) '()]
        [(integer? (/ n i)) (cons i (f (+ i 1)))]
        [else (f (+ i 1))])))) 

(define divisorsf
  (lambda (n)
    (let f ([i 1])
      (cond
        ((> i (floor (sqrt n))) 0)
        ((integer? (/ n i)) (+ 2 (f (+ i 1))))
        (else (f (+ i 1)))))))

(define triangle-number
  (lambda (n)
    (/ (* n (+ 1 n)) 2)))

(define find-triangle
  (lambda (n start)
    (cond
      ((> (divisorsf (triangle-number start)) n)
       start)
      (else (and (fprintf (current-output-port) "recurring with ~a ~a\n" start (triangle-number start)) 
                 (find-triangle n (+ 1 start)))))))

(define find-triangle-gt
  (lambda (n)
    (find-triangle n 1)))

