#lang scheme
(list->string (take 
                (string->list (number->string 
                        (reduce + (map string->number 
                                       (file->lines "13.input")) 0))) 
                10))
