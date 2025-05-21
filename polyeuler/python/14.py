#!/usr/bin/env python3
import functools


@functools.lru_cache(maxsize=1_000_000)
def collatz(n):
    if n == 1:
        return 1
    return collatz(3 * n + 1 if n % 2 else n // 2) + 1


print(max({collatz(n): n for n in range(1, 1_000_000)}.items())[1])
