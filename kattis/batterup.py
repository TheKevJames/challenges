#!/usr/bin/env python3
def main(_, x):
    hits = [y for y in map(int, x.split()) if y >= 0]
    return sum(hits) / len(hits)


if __name__ == '__main__':
    print(main(input(), input()))
