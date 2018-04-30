#!/usr/bin/env python3
def main(_, x):
    return sum(1 for y in x.split() if int(y) < 0)


if __name__ == '__main__':
    print(main(input(), input()))
