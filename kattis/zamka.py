#!/usr/bin/env python3
def get_n(l, d, x):
    for y in range(l, d + 1):
        if sum(int(i) for i in str(y)) == x:
            return y

def get_m(l, d, x):
    for y in range(d, l - 1, -1):
        if sum(int(i) for i in str(y)) == x:
            return y

def main(l, d, x):
    l, d, x = int(l), int(d), int(x)
    n = get_n(l, d, x)
    m = get_m(l, d, x)
    return f'{n}\n{m}'


if __name__ == '__main__':
    print(main(input(), input(), input()))
