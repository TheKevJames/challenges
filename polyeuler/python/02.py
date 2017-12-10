#!/usr/bin/env python3
i, j = 1, 1
s = 0
while j < 4000000:
    if not j % 2:
        s += j

    i, j = j, i + j

print(s)
