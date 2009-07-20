

def read_grid(file):
    grid = []
    data = open(file).read()
    for line in data.split('\n'):
        rowdata = line.split(' ')
        if len(rowdata) == 0 or rowdata[0] == '':
            break
        grid.append([int(val) for val in rowdata])

    return grid


def compute_max_adj_n(grid, n):

    maxn = 0
    alln = []
    # col wise
    for row in range(len(grid)):
        nums = []
        for col in range(len(grid[row]) - n + 1):
            for colwin in range(col, col + n):
                print "summing row %d and col %d" % (row, colwin)
                nums.append(grid[row][colwin])
                if len(nums) == n:
                    set = reduce(lambda x, y: x * y, nums)
                    alln.append(set)
                    print "col wise set ", nums, set
                    if (set > maxn):
                        maxn = set
                    nums = []

    # row wise
    for col in range(len(grid[0])):
        set = 1
        for row in range(len(grid) - n + 1):
            for rowwin in range(row, row + n):
                print "summing row %d and col %d" % (rowwin, col)
                nums.append(grid[rowwin][col])
                if len(nums) == n:
                    set = reduce(lambda x, y: x * y, nums)
                    alln.append(set)
                    print "row wise set ", nums, set
                    if (set > maxn):
                        maxn = set
                    nums = []

    # down and left
    for row in range(len(grid) - n + 1):
        rowset = range(row, row + n)
        for col in range(len(grid[0]) - n + 1):
            set = 1
            colset = range(col, col + n)
            colset.reverse()
            nums = []
            for i in range(n):
                nums.append(grid[rowset[i]][colset[i]])
            set = reduce(lambda x, y: x * y, nums)
            alln.append(set)
            print "dl product ", rowset, colset, nums, set
            if (set > maxn):
                maxn = set

    # up and right
    for row in range(len(grid) - n + 1):
        rowset = range(row, row + n)
        for col in range(len(grid[0]) - n + 1):
            set = 1
            colset = range(col, col + n)
            nums = []
            for i in range(n):
                nums.append(grid[rowset[i]][colset[i]])
            set = reduce(lambda x, y: x * y, nums)
            alln.append(set)
            print "ur  product ", rowset, colset, nums, set
            if (set > maxn):
                maxn = set



    alln.sort()
    print alln
    return maxn


grid = read_grid('grid.txt')
print grid
max = compute_max_adj_n(grid, 4)
print max
