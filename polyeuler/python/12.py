#!/usr/bin/env python3
import itertools
import math


def divisors(n):
    for i in range(1, int(math.sqrt(n) + 1)):
        if not n % i:
            yield i
            if i * i != n:
                yield n / i


def triangle_numbers():
    val = 0
    for i in itertools.count(1):
        val += i
        yield val


for number in triangle_numbers():
    if len(list(divisors(number))) > 500:
        print(number)
        break
