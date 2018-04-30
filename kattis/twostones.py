#!/usr/bin/env python3
def main(n):
    return ['Bob', 'Alice'][int(n) & 1]


if __name__ == '__main__':
    print(main(input()))
