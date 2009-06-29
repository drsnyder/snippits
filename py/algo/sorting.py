from random import randint

def build_list(n):
    return [randint(1,1000000) for i in xrange(n)]

def bubble(l):
    swapped = True
    n = 0
    while swapped:
        for i in len(l) - 1:
            if l[i] > l[i + 1]:


print build_list(10)
