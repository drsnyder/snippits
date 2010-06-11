#lang scheme/base

(define addword 
  (lambda (wordlist word)
    (set! wordlist (append wordlist (list word (length wordlist))))))

(define wordpart
  (lambda (wordlistelement)
    (car wordlistelement)))

(define metapart
  (lambda (wordlistelement)
    (cadr wordlistelement)))

; hours
(define load
  (lambda (wordfile)
    (let ([wordlist '()]
          [count 0]
          )
        (for ([line (file->lines wordfile)])
             (set! count (+ count 1))
             ; (fprintf (current-output-port) "adding line ~s ~s~n" count line)
             (cond [(eq? (remainder count 10) 0)
               (fprintf (current-output-port) "adding line ~s~n" line)])
             (set! wordlist (append wordlist (list line count))))
        wordlist)))


; ~second
(define load2
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
