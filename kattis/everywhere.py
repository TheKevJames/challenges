#!/usr/bin/env python3
def main(n, *cases):
    values = []
    for _ in range(int(n)):
        x = int(cases[0])
        values.append(len(set(cases[1:x + 1])))
        cases = cases[x + 1:]
    return '\n'.join(str(x) for x in values)


if __name__ == '__main__':
    n = input()
    cases = []
    for _ in range(int(n)):
        x = input()
        cases.append(x)
        cases.extend([input() for _ in range(int(x))])
    print(main(n, *cases))
