(module tree mzscheme
    (define-syntax while
      (syntax-rules ()
                    ((while condition body ...)
                     (let loop ()
                       (if condition
                         (begin
                           body ...
                           (loop))
                         #f)))))
    
    ; optionally allow left and right parameters to be specified
    (define tree-create
      (case-lambda
            [(value) (list '() value '())]
            [(value left) (list left value '())]
            [(value left right) (list left value right)]))

    (define tree-left
      (lambda (tree) (car tree)))

    (define tree-value
      (lambda (tree) (car (cdr tree))))

    (define tree-right
      (lambda (tree) (car (cdr (cdr tree)))))

    ; no longer needed?
    (define tree-set-right
      (lambda (tree value)
        (list (tree-left tree) (tree-value tree) (tree-create value))
      

(provide tree-create tree-left tree-value tree-right))

