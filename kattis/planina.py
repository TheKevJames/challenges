#!/usr/bin/env python3
def main(n):
    return (2 + sum(2 ** x for x in range(int(n)))) ** 2


if __name__ == '__main__':
    print(main(input()))
