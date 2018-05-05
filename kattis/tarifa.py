#!/usr/bin/env python3
def main(x, _, *ps):
    x = int(x)
    return x + sum(x - int(p) for p in ps)


if __name__ == '__main__':
    x = input()
    n = input()
    ps = [input() for _ in range(int(n))]
    print(main(x, n, *ps))
