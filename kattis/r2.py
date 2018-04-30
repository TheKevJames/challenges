#!/usr/bin/env python3
def main(x):
    r1, s = x.split()
    return 2 * int(s) - int(r1)


if __name__ == '__main__':
    print(main(input()))
