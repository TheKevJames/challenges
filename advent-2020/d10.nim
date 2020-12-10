import algorithm
import sequtils
import strutils

proc buildMap(xs: seq[string]): seq[int] =
  let ints = map(xs, parseInt)
  concat(@[0], sorted(ints), @[max(ints) + 3])

proc part1(xs: seq[string]): int =
  let ordered = buildMap(xs)
  var ones = 0
  var threes = 0
  for i, val in ordered[1 .. high(ordered)]:
    let diff = val - ordered[i]
    if diff == 1:
      ones += 1
    else:
      threes += 1
  ones * threes

proc findCombinations(xs: seq[int]): int =
  var dyn = newSeqWith(max(xs) + 1, 0)
  dyn[0] = 1

  for i in xs[1 .. high(xs)]:
    dyn[i] = dyn[i - 1]
    if i >= 2:
      dyn[i] += dyn[i - 2]
    if i >= 3:
      dyn[i] += dyn[i - 3]

  dyn[high(dyn)]

proc part2(xs: seq[string]): int =
  findCombinations(buildMap(xs))

let f = strip(readFile("in10")).splitLines()
echo f.part1()
echo f.part2()
