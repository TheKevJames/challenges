import sequtils
import strutils

proc toSeat(xs: string): int =
  let row = fromBin[int](xs[0 .. 6].replace('B', '1').replace('F', '0'))
  let col = fromBin[int](xs[7 .. 9].replace('R', '1').replace('L', '0'))
  row * 8 + col

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
