(module search mzscheme
; provides vector-reverse!, vector-swap!
; (require srfi/43)
; provides vector-copy
(require racket/vector)
    (define-syntax while
      (syntax-rules ()
                    ((while condition body ...)
                     (let loop ()
                       (if condition
                         (begin
                           body ...
                           (loop))
                         #f)))))
    
    ; (define debug
    ;     (lambda (args) 
    ;       ))
    
    (define wordpart
      (lambda (wordlistelement)
        (car wordlistelement)))

    (define metapart
      (lambda (wordlistelement)
        (cadr wordlistelement)))

    ; ~second
    ; cpu time: 776 real time: 7991 gc time: 428
    (define list-load-wordfile
      (lambda (wordfile)
        
        (define loadwords
            (lambda (in wordlist count)
              (let ([line (read-line in)])
                (cond [(eof-object? line) wordlist]
                      [else (loadwords in (cons (list line count) wordlist) (+ 1 count))]))))

        (define in (open-input-file wordfile))
        (define words (loadwords in '() 0))
        (close-input-port in)
        (reverse words)))

    
    ; load the wordfile as a list and return it as a vector
    (define load-wordfile
      (lambda (wordfile)
        (list->vector (list-load-wordfile wordfile))))


    (define vector-swap!
      (lambda (wordvector a b)
        (let ([tmp (vector-ref wordvector a)])
          (vector-set! wordvector a (vector-ref wordvector b))
          (vector-set! wordvector b tmp))))



    ; compare the wordpart of two vectors
    (define wordvector-compare?
      (lambda (a b)
         (string<? (wordpart a) (wordpart  b))))


    (define vector-delete!
      (lambda (v index)
        (cond [(or (>= index (vector-length v)) (> 0 index)) v]
              [(= index 0) (vector-copy v 1 (vector-length v))]
              [(= index (- (vector-length v) 1)) (vector-copy v 0 (- (vector-length v) 1))]
              [else (vector-append 
                      (vector-copy v 0 index) 
                      (vector-copy v (+ index 1) (vector-length v)))])))

    ; returns the index or #f if not found
    ; use with a vector of numbers (vector-search v1 85 (lambda (x) x))
    (define vector-search
      (lambda (v s f?)
        (let/ec return
          (let while ([low 0] 
                      [high (- (vector-length v) 1)])
            (let ([mid (round (/ (+ low high) 2))])
                  (fprintf (current-output-port) "low ~s med ~s high ~s~n" low mid high)
                (unless (>= low high)

                  (cond [(= (f? (vector-ref v mid)) s) (return mid)]
                        [(> (f? (vector-ref v mid)) s) (while low mid)]
                        [else (while mid high)]))))
          #f)))


    (define vector-quicksort!
      (lambda (v f?)

        (define sort
          ; using offset makes the index calculations more confusing. i think
          ; if i did it again i would use a left and right index 
          (lambda (v offset len)
            (cond [(> len 1)
                    ; take the pivot from the middle
                    (let ([p (- (truncate (/ len 2)) 1)] 
                          [last offset])

                        (vector-swap! v offset (+ offset p))


                        (do ((i (+ offset 1) (+ i 1)))
                          ((= i (+ offset len)))

                          (cond
                            [(f? (vector-ref v i) (vector-ref v offset)) 
                             (set! last (+ last 1)) 
                             (vector-swap! v i last)]))

                        (vector-swap! v offset last)

                        (sort v offset (- last offset))
                        ; (sort v left last)
                        ; (sort v left+1, right)
                        (sort v (+ last 1) (- (+ offset len) last 1)))]))) 

        (sort v 0 (vector-length v))))


    (define reverse-vector!
      (lambda (wv n)
        (do ((i 0 (+ i 1))) 
          ((= i (/ n 2))) 
            ; (display (vector-ref wv i))
            ; (display (vector-ref wv (- n i 1)))
            (vector-swap! wv i (- n i 1)))))


    ; (define addword 
    ;   (lambda (wordlist word)
    ;     (set! wordlist (append wordlist (list word (length wordlist))))))


    ; hours
    ; (define load
    ;   (lambda (wordfile)
    ;     (let ([wordlist '()]
    ;           [count 0]
    ;           )
    ;         (for ([line (file->lines wordfile)])
    ;              (set! count (+ count 1))
    ;              ; (fprintf (current-output-port) "adding line ~s ~s~n" count line)
    ;              (cond [(eq? (remainder count 10) 0)
    ;                (fprintf (current-output-port) "adding line ~s~n" line)])
    ;              (set! wordlist (append wordlist (list line count))))
    ;         wordlist)))

    ; we could do a list->vector operation from the above to create a vector. seems
    ; wasteful though. we would create the list and then the vector
    ; cpu time: 711 real time: 9383 gc time: 496
    ; (define vwlist
    ;   (lambda (vdata)
    ;     (car vdata)))

    ; (define vwlength
    ;   (lambda (vdata)
    ;     (cdr vdata)))

    ; (define vector-load-wordfile
    ;   (lambda (wordfile size)

    ;     (define wordvector (make-vector size 0)) 

    ;     (define loadwords
    ;         (lambda (in count)
    ;           (let ([line (read-line in)])
    ;             (cond [(eof-object? line) count]
    ;                   [else 
    ;                     (and (vector-set! wordvector count (list line count))
    ;                          (loadwords in (+ 1 count)))]))))

    ;     (define in (open-input-file wordfile))
    ;     (define loaded-values (loadwords in 0))
    ;     (close-input-port in)
    ;     (cons wordvector loaded-values)))
    ;
    ; (let ( [offset 0] [len 10] )
    ;     (do ((i offset (+ i 1)))
    ;       ((= i (+ offset len)))
    ;       (display i)))

(provide load-wordfile  vector-swap! reverse-vector! vector-quicksort! 
         vector-delete! wordvector-compare?))

