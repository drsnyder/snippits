from math import *
from prime import *


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


print "35 ",isprime1(35)
print "17 ",isprime1(17)
print "11 ",isprime1(11)
print "10 ",isprime1(10)
print "7621 ",isprime1(7621)
print "9 ",isprime1(9)

print findlargestpfactordown(13195)
print findlargestpfactordown(600851475143)

