#!/usr/bin/env python
i, j = 1, 1
s = 0
while j < 4000000:
    if j % 2 == 0:
        s += j

    i, j = j, i + j

print s
