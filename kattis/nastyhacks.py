#!/usr/bin/env python3
def main(_, *xs):
    actions = []
    for a, b, c in (map(int, x.split()) for x in xs):
        d = b - c
        actions.append('advertise' if d > a else
                       'does not matter' if d == a else 'do not advertise')
    return '\n'.join(actions)


if __name__ == '__main__':
    n = input()
    xs = [input() for _ in range(int(n))]
    print(main(n, *xs))
