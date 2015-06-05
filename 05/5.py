#!/usr/bin/env python
r = range(2, 20)
s = 1

while r:
    s *= r[0]
    r = map(lambda x: x / r[0] if x % r[0] == 0 else x, r[1:])

print s
