#!/usr/bin/env python3
def main(l):
    return ''.join(x[0] for x in l.split('-'))


if __name__ == '__main__':
    print(main(input()))
