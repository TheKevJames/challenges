#!/usr/bin/env python
print sum(xrange(1, 101)) ** 2 - sum(map(lambda x: x * x, xrange(1, 101)))
