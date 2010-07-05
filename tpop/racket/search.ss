(module search mzscheme
(require srfi/43)
    
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


    (define vector-swap
      (lambda (wordvector a b)
        (let ([tmp (vector-ref wordvector a)])
          (vector-set! wordvector a (vector-ref wordvector b))
          (vector-set! wordvector b tmp))))




(let ( [offset 0] [len 10] )
    (do ((i offset (+ i 1)))
      ((= i (+ offset len)))
      (display i)))


    (define wordvector-compare?
      (lambda (a b)
         (string<? (wordpart a) (wordpart  b))))

    (define vector-quicksort!
      (lambda (v f?)

        (define sort
          (lambda (v offset len)
            (cond [(>= 1 len)]
                  [else 
                    ; take the pivot from the middle
                    (let ([p (- (truncate (/ len 2)) 1)] 
                          [last offset])


                        (fprintf (current-output-port) 
                                 "set p to ~s offset ~s len ~s ~n" (+ offset p) offset len) 

                        (fprintf (current-output-port) 
                                 "swapping ~s with ~s ~n" (vector-ref v offset) 
                                 (vector-ref v (+ offset p))) 

                        (vector-swap! v offset (+ offset p))

                        ; (fprintf (current-output-port) 
                        ;          "wp ~s last ~s ~n" (wordpart (vector-ref v p)) last) 

                        ;   (fprintf (current-output-port) "comparing ~s to ~s~n"  
                        ;            (wordpart (vector-ref v last))
                        ;            (wordpart (vector-ref v p)))

                        (do ((i (+ offset 1) (+ i 1)))
                          ((= i (+ offset len)))

                          (fprintf (current-output-port) "looping ~s ~s ~s to ~s ~n" 
                                   i offset len (+ offset (- len 1)))  
                          ; (fprintf (current-output-port) "comparing ~s to ~s~n"  
                          ;          (wordpart (vector-ref v i))
                          ;          (wordpart (vector-ref v last)))
                          ; (flush-output (current-output-port)) 

                          (cond
                            [(f? (vector-ref v i) (vector-ref v offset)) 
                             (set! last (+ last 1)) 
                             (vector-swap! v i last)
                             ]))

                        (vector-swap! v offset last)

                        (fprintf (current-output-port) "1:(sort v ~s ~s) o ~s l ~s ln ~s ~n" 
                                 offset (- last offset) offset last len)  
                        (sort v offset (- last offset))
                        (fprintf (current-output-port) "2:(sort v ~s ~s) o ~s l ~s ln ~s ~n" 
                                 (+ last 1) (- (+ offset len) last 1) offset last len)  
                        (sort v (+ last 1) (- (+ offset len) last 1)))]))) 

        (sort v 0 (vector-length v))))


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

(provide load-wordfile  vector-swap reverse-vector vector-quicksort! wordvector-compare?))

