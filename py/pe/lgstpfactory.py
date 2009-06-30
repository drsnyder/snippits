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


def findlargestpfactordown(n):
    start = round(sqrt(n))
    while start >= 2:
        if start != 2 and (start % 2) == 0:
            # skip factors of 2
            start -= 1
            continue
        if not isprime(start):
            start -= 1
            continue

        if (n % start) == 0:
            return start
        start -= 1

    return start

def find_nth_prime(n):
    pcount = 0
    i = 1
    while pcount < n:
        i += 1
        if i != 2 and (i % 2) == 0:
            continue

        if isprime(i):
            #print "%d %d %d" % (pcount, i, n)
            pcount += 1


    return i



        


print "35 ",isprime(35)
print "17 ",isprime(17)
print "11 ",isprime(11)
print "10 ",isprime(10)
print "7621 ",isprime(7621)
print "9 ",isprime(9)

#print findlargestpfactordown(13195)
#print findlargestpfactordown(600851475143)

print find_nth_prime(100000)
