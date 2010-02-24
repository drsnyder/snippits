; 1.10 lisp

(defun A (x y)
  (cond 
    ((= y 0) 0)
    ((= x 0) (* 2 y))
    ((= y 1) 2)
    (t (A (- x 1)
          (A x (- y 1))))))

(defun ackermann (m n)
  (cond ((zerop m) (1+ n))
        ((zerop n) (ackermann (1- m) 1))
        (t         (ackermann (1- m) (ackermann m (1- n))))))

