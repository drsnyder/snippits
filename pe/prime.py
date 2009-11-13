from math import *

def isprime(n):
    if n == 1 or n == 2:
        return True

    if (n % 2) == 0:
        return False

    start = 3
    stop = round(sqrt(n))
    while start <= stop:
        #print "isprime: %d %% %d = %d --> %d" % (n, start, n % start, stop)
        if (start % 2) == 0:
            # skip factors of 2
            start += 1
            continue

        if (n % start) == 0: 
            return False
        start += 1

    return True

def isprime1(n):
    if n == 1: 
        return False

    if n == 2:
        return True

    if n == 3:
        return True

    if (n % 2) == 0:
        return False

    if (n % 3) == 0:
        return False

    start = 5
    end = round(sqrt(n))
    while start <= end:
        if (n % start) == 0:
            return False

        # primes are 6k +/- 1, and we're starting at 6*1 - 1
        test = start + 2
        if (n % test) == 0:
            return False

        start += 6

    return True


def find_nth_prime(n):
    pcount = 0
    i = 1
    while pcount < n:
        i += 1
        if i != 2 and (i % 2) == 0:
            continue

        if isprime1(i):
            #print "%d %d %d" % (pcount, i, n)
            pcount += 1


    return i

def prime_generator(max):

    if max >= 2:
        yield 2
    if max >= 3:
        yield 3

    start = 4
    while start <= max:
        if (start % 2) == 0 or (start % 3) == 0:
            start += 1
            continue

        if isprime1(start):
            yield start

        start += 1

    


