# 009
def quad(a, b, c):
    return ((a**2 + b**2) == c**2)

def solver():
    for c in range(1, 998):
        for b in range(1, c):
            for a in range(1, b):
                if quad(a, b, c):
                    if (a + b + c) == 1000:
                        print "%d, %d, %d" % (a, b, c)
                        return a, b, c


print solver()
