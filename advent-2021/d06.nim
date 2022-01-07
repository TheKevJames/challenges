import std/sequtils
import std/strutils
import std/tables

proc tick(fish: CountTable[int]): CountTable[int] =
  for i in 0 .. 8:
    result[i] = fish[i + 1]

  result[8] = fish[0]
  result[6] = result[6] + fish[0]

proc part1(xs: seq[string]): int =
  var fish = toCountTable(map(xs[0].split(','), parseInt))
  for i in 0 ..< 80:
    fish = tick(fish)
  toSeq(values(fish)).foldl(a + b)

proc part2(xs: seq[string]): int =
  var fish = toCountTable(map(xs[0].split(','), parseInt))
  for i in 0 ..< 256:
    fish = tick(fish)
  toSeq(values(fish)).foldl(a + b)

let f = strip(readFile("in06")).splitLines()
echo f.part1()
echo f.part2()
