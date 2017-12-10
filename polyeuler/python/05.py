#!/usr/bin/env python3
r = list(range(2, 20))
s = 1

while r:
    s *= r[0]
    r = list(map(lambda x: x if x % r[0] else x / r[0], r[1:]))

print(int(s))
