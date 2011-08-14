(define (factorial n)
  (if (= n 1)
    1
    (* n (factorial (- n 1)))))

(define (fact-i n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

(define (inc a)
    (+ a 1))

(define (dec a)
    (- a 1))

(define (pr a b)
  (if (= a 0)
      b
      (inc (pr (dec a) b))))

(define (pi a b)
  (if (= a 0)
      b
      (pi (dec a) (inc b))))

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(A 2 1) = 2 2
(A 2 2) = 4 2^2
(A 2 3) = 16 2^(2^2)
(A 2 4) = 65536 2^(2^(2^2))

(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount (- kinds-of-coins 1)) (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

10
5 5
11111 5
11111 11111

15
5 5 5
5 10
5 5 11111
111111111111111
10 11111
11111 11111 5

10
1s yes
5s yes
10s yes


;  f(n) = n if n<3
; f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) 
(define (f3 n)
  (cond ((< n 3) n)
        (else (+ (f3 (- n 1)) 
                 (* 2 (f3 (- n 2)))
                 (* 3 (f3 (- n 3)))))))

(define (f a b c) (+ a (* 2 b) (* 3 c)))

(define (f3-iter a b c n)
  (cond ((= n 3) (f a b c))
        (else (f3-iter (f a b c) a b (- n 1)))))


(define (f3i n)
  (cond ((< n 3) n)
        (else (f3-iter 2 1 0 n))))

