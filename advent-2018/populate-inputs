#!/usr/bin/env bash
COOKIES="Cookie: _ga=GA1.2.1901433359.1543467254; _gid=GA1.2.191967706.1545947922; session=53616c7465645f5f17ed7bea4b37fdce974ad04e75c0ecb732427d30836185f0bebb625bb8a0248b15c2c8cf698b4c74"

for day in {1..25}; do
    curl -s -H "${COOKIES}" "https://adventofcode.com/2018/day/${day}/input" > $(printf "in%02d" "${day}")
done
