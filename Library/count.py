#coding=utf-8

def add(a,b):
    u'''
    用于计算a,b两数相加的结果，例：
    | add | a | b |
    '''
    c = int(a)
    d = int(b)
    return c + d

def sub(a,b):
    u'''
    用于计算a,b两数相减的结果，例：
    '''
    c = int(a)
    d = int(b)
    return c - d

if __name__ == "__main__":
    e = add(3,5)
    print (e)
    e = sub(3,7)
    print (e)

