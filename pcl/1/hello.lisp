(defun hello-world () (format t "Hello, World!"))
(defun fib (n)
    (if (< n 2)
	n
	(+ (fib (- n 1)) (fib (- n 2)))))