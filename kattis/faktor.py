#!/usr/bin/env python3
def main(x):
    a, i = x.split()
    return int(a) * (int(i) - 1) + 1


if __name__ == '__main__':
    print(main(input()))
