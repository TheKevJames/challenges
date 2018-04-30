#!/usr/bin/env python3
def main(x):
    k, q, r, b, n, p = x.split()
    return f'{1 - int(k)} {1 - int(q)} {2 - int(r)} {2 - int(b)} {2 - int(n)} {8 - int(p)}'


if __name__ == '__main__':
    print(main(input()))
