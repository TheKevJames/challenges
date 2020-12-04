import sequtils
import strutils

proc part1(xs: seq[int], target = 2020): int =
  for x in xs:
    if target-x in xs:
      return x * (target-x)

proc part2(xs: seq[int]): int =
  for i, x in xs:
    let res = part1(xs[i .. high(xs)], target=2020-x)
    if res != 0:
      return x * res

let f = map(strip(readFile("in01")).splitLines(), parseInt)
echo f.part1()
echo f.part2()
