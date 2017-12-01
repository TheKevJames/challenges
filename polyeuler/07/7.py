#!/usr/bin/env python
def get_nth(limit, n):
    sieve = [True] * limit
    sieve[0] = sieve[1] = False

    val = 0
    for i, prime in enumerate(sieve):
        if prime:
            val = i
            n -= 1
            if not n:
                return val

            for x in xrange(i, limit, i):
                sieve[x] = False


print get_nth(200000, 10001)
