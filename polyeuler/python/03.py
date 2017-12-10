#!/usr/bin/env python3
i = 2
n = 600851475143
while i * i < n:
    while not n % i:
        n /= i

    i += 1

print(int(n))
