#!/usr/bin/env python3
limit = 2000000

sieve = [True] * limit
sieve[0] = sieve[1] = False

val = 0
for i, prime in enumerate(sieve):
    if not prime:
        continue

    val += i

    for x in range(i, limit, i):
        sieve[x] = False

print(val)
