#!/usr/bin/env python3
def main(_, *xs):
    return sum(int(x[:-1]) ** int(x[-1]) for x in xs)


if __name__ == '__main__':
    n = input()
    xs = [input() for _ in range(int(n))]
    print(main(n, *xs))
