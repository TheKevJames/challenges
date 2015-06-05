#!/usr/bin/env python
from itertools import count


i, j = 1, 1
for idx in count():
    if len(str(j)) >= 1000:
        print idx + 2
        break

    i, j = j, i + j
