#!/usr/bin/env python
i = 2
n = 600851475143
while i * i < n:
    while n % i == 0:
        n /= i

    i += 1

print n
