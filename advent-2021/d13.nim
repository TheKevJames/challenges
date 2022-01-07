import std/sequtils
import std/strscans
import std/strutils
import std/sugar

proc debug(data: seq[seq[bool]]) =
  for row in data:
    echo map(row, (x) => (if x: "#" else: ".")).join()

proc parse(xs: seq[string], once: bool = false): seq[seq[bool]] =
  var points: seq[tuple[x: int, y: int]]
  for line in xs:
    var x, y: int
    if not scanf(line, "$i,$i", x, y):
      break

    points.add((x: x, y: y))

  result = newSeqWith(1 + max(points.map((t) => t.y)), newSeq[bool](1 + max(points.map((t) => t.x))))
  for point in points:
    result[point.y][point.x] = true

  for line in xs:
    var x, y: int
    if scanf(line, "fold along x=$i", x):
      for i in x + 1 .. result[0].high:
        for col in 0 .. result.high:
          result[col][2 * x - i] = (result[col][i] or result[col][2 * x - i])
      result = map(result, (row) => row[0 ..< x])
      if once:
        break

    if scanf(line, "fold along y=$i", y):
      for i in y + 1 .. result.high:
        for row in 0 .. result[0].high:
          result[2 * y - i][row] = (result[i][row] or result[2 * y - i][row])
      result = result[0 ..< y]
      if once:
        break

proc part1(xs: seq[string]): int =
  parse(xs, true).foldl(a + count(b, true), 0)

proc part2(xs: seq[string]): int =
  debug(parse(xs, false))  # yeah, not writing a parser for that
  0

let f = strip(readFile("in13")).splitLines()
echo f.part1()
echo f.part2()
