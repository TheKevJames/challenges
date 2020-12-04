import sequtils
import strutils

proc part1(xs: seq[string], right = 3): int =
  for step, row in xs:
    if step == 0:
      continue
    if row[(step * right) mod (high(row) + 1)] == '#':
      result += 1

iterator sliceStep(xs: seq[string], step = 1): string =
  for i in countUp(0, high(xs), step):
    yield xs[i]

proc part2(xs: seq[string]): int =
  part1(xs, right=1) * part1(xs, right=3) * part1(xs, right=5) * part1(xs, right=7) * part1(toSeq(sliceStep(xs, 2)), right=1)

let f = strip(readFile("in03")).splitLines()
echo f.part1()
echo f.part2()
