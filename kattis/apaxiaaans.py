#!/usr/bin/env python3
import itertools


def main(xs):
    return ''.join(x for x, _ in itertools.groupby(xs))


if __name__ == '__main__':
    print(main(input()))
