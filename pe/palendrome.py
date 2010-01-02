
def findlargestpalendrom(ndigits):
    upper = 10**ndigits - 1
    bound = 10**(ndigits - 1)

    largest = 0
    while upper >= bound:
        start = 10**ndigits - 1
        while start >= bound:
            #print "%d x %d = %d" % (upper, start, upper * start)
            potential = str(upper * start)
            if (potential == potential[::-1]):
                if ((upper * start) > largest):
                    largest = upper * start

            start -= 1
        upper -= 1

    return largest



#print findlargestpalendrom(2)
print findlargestpalendrom(3)
