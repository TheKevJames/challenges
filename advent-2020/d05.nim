import sequtils
import strutils

proc toSeat(xs: string): int =
  fromBin[int](xs.multiReplace(("B", "1"), ("R", "1"), ("F", "0"), ("L", "0")))

proc part1(xs: seq[string]): int =
  let seats = map(xs, toSeat)
  max(seats)

proc part2(xs: seq[string]): int =
  let seats = map(xs, toSeat)
  var myseat = foldl(seats, a xor b, 0)
  foldl(min(seats)..max(seats), a xor b, myseat)

let f = strip(readFile("in05")).splitLines()
echo f.part1()
echo f.part2()
