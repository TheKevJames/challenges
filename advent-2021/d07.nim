import std/algorithm
import std/sequtils
import std/strutils

proc part1(xs: seq[string]): int =
  let crabs = sorted(map(xs[0].split(','), parseInt))
  let gas = toSeq(0 .. max(crabs)).mapIt(crabs.foldl(a + abs(b - it), 0))
  min(gas)

proc part2(xs: seq[string]): int =
  let crabs = sorted(map(xs[0].split(','), parseInt))
  let gas = toSeq(0 .. max(crabs)).mapIt(crabs.foldl(a + int(abs(b - it) * (abs(b - it) + 1) / 2), 0))
  min(gas)

let f = strip(readFile("in07")).splitLines()
echo f.part1()
echo f.part2()
