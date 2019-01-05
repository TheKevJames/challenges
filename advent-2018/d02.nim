import sequtils
import strutils
import tables

proc part1(xs: seq[string]): int =
  var twos, threes = 0

  for x in xs:
    let vals = toSeq(x.toCountTable().values())
    if 2 in vals:
      twos += 1
    if 3 in vals:
      threes += 1

  twos * threes

proc part2(xs: seq[string]): string =
  for x1 in xs:
    for x2 in xs:
      let unique = zip(x1, x2).filterIt(it.a == it.b)
      if x1.len == unique.len + 1:
        return unique.foldl(a & b.b, "")

let f = strip(readFile("in02")).splitLines()
echo f.part1()
echo f.part2()
