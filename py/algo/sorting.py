from random import randint
from math import *

def build_list(n, min=1, max=1000000):
    return [randint(min,max) for i in xrange(n + 1)]

def bubble(l):
    swapped = True
    n = 0
    count = 0
    while swapped:
        swapped = False
        for i in range(len(l) - 1):
            count += 1
            if l[i] > l[i + 1]:
                temp = l[i]
                l[i] = l[i + 1]
                l[i + 1] = temp
                swapped = True

    return count


def concat(less, pivot, greater):
    final = []
    for e in less:
        final.append(e)
    final.append(pivot)
    for e in greater:
        final.append(e)

    return final
        
quickcount = 0
def quick(l):
    global quickcount
    #print "# quick #"
    if len(l) <= 1:
        return l

    pivot = l[-1]
    l.pop()
    less = []
    greater = []
    for i in range(len(l)):
        quickcount += 1
        #print "looking at pivot %d and %d" % (pivot, l[i])
        if l[i] > pivot: 
            greater.append(l[i])
        else:
            less.append(l[i])

    return concat(quick(less), pivot, quick(greater))



l = build_list(100)
iter = bubble(l)
print "Required %d iterations from %d items bounded by %d" % (iter, len(l), len(l) * len(l))

l.reverse()
iter = bubble(l)
print "Required %d iterations from %d items bounded by %d" % (iter, len(l), len(l) * len(l))

print "######################"

x = build_list(10, 1, 10)
print x
quickcount = 0
x = quick(x)
print x
print "Required %d iterations from %d items bounded by %d" % (quickcount, len(x), (len(x) * log(len(x), 2)))

x.reverse()
print x
quickcount = 0
x = quick(x)
print x
print "Required %d iterations from %d items bounded by %d" % (quickcount, len(x), (len(x) * log(len(x), 2)))

