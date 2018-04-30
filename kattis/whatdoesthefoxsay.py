#!/usr/bin/env python3
def split_cases(l):
    case = []
    for item in l:
        if item == 'what does the fox say?':
            yield case
            case = []
            continue

        case.append(item)


def main(_, *x):
    return '\n'.join(' '.join(word for word in case[0].split()
                              if word not in {l.split()[2] for l in case[1:]})
                     for case in split_cases(x))


if __name__ == '__main__':
    n = int(input())
    inputs = []
    while True:
        x = input()
        inputs.append(x)
        if x == 'what does the fox say?':
            n -= 1
            if n == 0:
                break
    print(main(n, *inputs))
