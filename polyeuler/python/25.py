#!/usr/bin/env python3
import itertools


i, j = 1, 1
for idx in itertools.count():
    if len(str(j)) >= 1000:
        print(idx + 2)
        break

    i, j = j, i + j
