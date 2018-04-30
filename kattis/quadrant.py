#!/usr/bin/env python3
def main(x, y):
    return [[3, 2], [4, 1]][int(x) > 0][int(y) > 0]


if __name__ == '__main__':
    print(main(input(), input()))
