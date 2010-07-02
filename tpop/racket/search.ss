(module search mzscheme
(require srfi/43)
    
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




    (define vector-swap
      (lambda (wordvector a b)
        (let ([tmp (vector-ref wordvector a)])
          (vector-set! wordvector a (vector-ref wordvector b))
          (vector-set! wordvector b tmp))))




; (let ( [offset 0] [len 10] )
;     (do ((i offset (+ i 1)))
;       ((= i (- (+ offset len) 1)))
;       (display i)))


    (define vector-quicksort!
      (lambda (wordvector)

        (define sort
          (lambda (wv offset len)
            (cond [(>= 1 len) wv]
                  [else 
                    ; take the pivot from the middle
                    (let ([p (truncate (/ (+ offset len) 2))] 
                          [last 0])


                        (fprintf (current-output-port) 
                                 "set p to ~s offset ~s len ~s ~n" p offset len) 

                        (vector-swap! wv 0 p)

                        (fprintf (current-output-port) 
                                 "wp ~s last ~s ~n" (wordpart (vector-ref wv p)) last) 

                          (fprintf (current-output-port) "comparing ~s to ~s~n"  
                                   (wordpart (vector-ref wv last))
                                   (wordpart (vector-ref wv p)))

                        (do ((i offset (+ i 1)))
                          ((= i (- (+ offset len) 1)))

                          (fprintf (current-output-port) "comparing ~s to ~s~n"  
                                   (wordpart (vector-ref wv i))
                                   (wordpart (vector-ref wv last)))
                          (flush-output (current-output-port)) 

                          (cond
                            [(string<? (wordpart (vector-ref wv i)) (wordpart (vector-ref wv last)))
                             (and (vector-swap! wv i last) (set! last (+ last 1)))]))

                        (vector-swap! wv 0 last)

                        (sort wv offset (+ offset last))
                        (sort wv (+ offset last 1) (- offset last 1)))]))) 

        (sort wordvector 0 (vector-length wordvector))))


    (define reverse-vector
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

(provide load-wordfile  vector-swap reverse-vector vector-quicksort!))

