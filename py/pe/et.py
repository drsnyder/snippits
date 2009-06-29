class A(object):

    def __init__(self, a, b):
        self.a = a
        self.b = b

    def update(self, a):
        self.a = a

    def update(self, a, b):
        self.a = a
        self.b = b


a = A(1, 2)
a.update(3)
a.update(3, 4)
