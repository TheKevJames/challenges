#!/usr/bin/env python3
def is_palindrome(val):
    cast = str(val)
    return cast == cast[::-1]

highest = 0
for i in range(1000, 100, -1):
    for j in range(i, 100, -1):
        prod = i * j
        if is_palindrome(prod):
            highest = prod if prod > highest else highest

print(highest)
