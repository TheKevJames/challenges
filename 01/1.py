#!/usr/bin/env python
print sum(
    filter(
        lambda x: x % 3 == 0 or x % 5 == 0,
        xrange(1000)
    )
)
