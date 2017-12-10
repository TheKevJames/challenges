#!/usr/bin/env python3
def get_nth(limit, n):
    sieve = [True] * limit
    sieve[0] = sieve[1] = False

    val = 0
    for i, prime in enumerate(sieve):
        if not prime:
            continue

        val = i
        n -= 1
        if not n:
            return val

        for x in range(i, limit, i):
            sieve[x] = False


print(get_nth(200000, 10001))
