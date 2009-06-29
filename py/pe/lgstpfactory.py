from math import *
def isprime(n):
    start = 2
    stop = round(sqrt(n))
    while start < stop:
        if start != 2 and (start % 2) == 0:
            # skip factors of 2
            start += 1
            continue

        if (n % start) == 0: 
            break
        start += 1
    else:
        return True

    return False

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
        


print isprime(35)
print isprime(17)
print isprime(11)
print isprime(10)

print findlargestpfactordown(13195)
print findlargestpfactordown(600851475143)
