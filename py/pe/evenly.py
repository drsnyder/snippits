
def find_evenly_divisible(n):
    curr = n
    while True:
        alldiv = True
        for x in range(1, n + 1):
            if (curr % x) != 0:
                alldiv = False
                break
        if alldiv:
            return curr

        curr += 1

def find_evenly_divisible20():
    curr = 20 
    while True:
        alldiv = True
        for x in [20, 19, 18, 17, 16, 14, 13, 11]:
            if (curr % x) != 0:
                alldiv = False
                break
        if alldiv:
            return curr

        curr += 1

print find_evenly_divisible(10)
print find_evenly_divisible20()


