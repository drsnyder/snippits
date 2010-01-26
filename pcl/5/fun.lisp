(defun plus (&rest numbers)
  (if (equal nil numbers)
      0
      (+ (car numbers) (plus (cdr numbers)))))

