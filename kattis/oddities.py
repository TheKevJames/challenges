#!/usr/bin/env python3
def main(_, *xs):
    return '\n'.join(f'{x} is {"odd" if int(x) % 2 else "even"}' for x in xs)


if __name__ == '__main__':
    n = input()
    xs = [input() for _ in range(int(n))]
    print(main(n, *xs))
