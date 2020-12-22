import sequtils
import strutils

proc play(xs: seq[string], turns: int): int =
  let vals = map(toSeq(xs[0].split(',')), parseInt)

  var record = newSeqWith(turns, 0)
  var last = vals[high(vals)]
  var turn = 1

  for val in vals[0 .. high(vals) - 1]:
    record[val] = turn
    turn += 1

  while turn < turns:
    let idx = record[last]
    if idx == 0:
      record[last] = turn
      last = 0
    else:
      record[last] = turn
      last = turn - idx
    turn += 1
  
  last

proc part1(xs: seq[string]): int =
  play(xs, 2020)

proc part2(xs: seq[string]): int =
  play(xs, 30000000)

let f = strip(readFile("in15")).splitLines()
echo f.part1()
echo f.part2()
