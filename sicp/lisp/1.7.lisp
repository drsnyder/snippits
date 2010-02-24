; 1.7 and 1.8 lisp
(defun sqrt-iter (previous guess x)
  (if (better-good-enough? previous guess)
      guess
      (sqrt-iter guess (improve guess x) x)))

(defun improve (guess x)
  (avg guess (/ x guess)))

(defun avg (x y)
  (/ (+ x y) 2.0))

(defun better-good-enough? (previous guess)
  (< (/ (abs (- previous guess)) guess) 0.00001))

(defun nt-sqrt (x)
  (sqrt-iter 0 1.0 x))

;;;;
(defun square (x)
  (* x x))

(defun cube-iter (previous guess x)
  (if (better-good-enough? previous guess)
    guess
    (cube-iter guess (cube-improve guess x) x)))

(defun cube-improve (guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(defun cubert (x)
  (cube-iter 0 1.0 x))
