
(define atom?
    (lambda (x)
      (and (not (pair? x)) (not (null? x)))))


(atom? (quote a))
(atom? (quote 1234))
(atom? (quote turkey))
