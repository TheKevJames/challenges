#!/usr/bin/env python
limit = 2000000

sieve = [True] * limit
sieve[0] = sieve[1] = False

val = 0
for i, prime in enumerate(sieve):
    if prime:
        val += i

        for x in xrange(i, limit, i):
            sieve[x] = False

print val
