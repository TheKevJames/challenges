import sequtils
import strutils

iterator windowed*[T](xs: seq[T], size: Positive): seq[T] =
  var i: int
  while i + size <= len(xs):
    yield xs[i ..< i + size]
    inc i

proc part1(xs: seq[int]): int =
  for x in windowed(xs, 2):
    result += int(x[1] > x[0])

proc part2(xs: seq[int]): int =
  var curr, prev: int
  for x in windowed(xs, 3):
    curr = x.foldl(a + b)
    result += int(curr > prev)
    prev = curr
  result -= 1  # deal with first item

let f = map(strip(readFile("in01")).splitLines(), parseInt)
echo f.part1()
echo f.part2()
