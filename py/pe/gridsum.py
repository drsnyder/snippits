

def read_grid(file):
    grid = []
    data = open(file).read()
    print data
    for line in data.split('\n'):
        rowdata = line.split(' ')
        print rowdata
        if len(rowdata) == 0 or rowdata[0] == '':
            break
        grid.append([int(val) for val in rowdata])

    return grid

grid = read_grid('grid.txt')
print grid
