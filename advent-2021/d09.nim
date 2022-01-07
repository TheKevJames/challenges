import std/algorithm
import std/sequtils
import std/strutils
import std/sets
import std/sugar

proc neighbours(xs: seq[seq[int]], x: int, y: int): seq[tuple[x: int, y: int]] =
  if x > 0:
    result.add((x: x - 1, y: y))
  if y > 0:
    result.add((x: x, y: y - 1))
  if y < xs.high:
    result.add((x: x, y: y + 1))
  if x < xs[0].high:
    result.add((x: x + 1, y: y))

proc lowpoints(xs: seq[seq[int]]): seq[tuple[x: int, y: int]] =
  for y in 0 .. xs.high:
    for x in 0 .. xs[0].high:
      if xs[y][x] < min(map(neighbours(xs, x, y), proc (v: tuple[x: int, y: int]): int = xs[v.y][v.x])):
        result.add((x: x, y: y))

proc part1(xs: seq[string]): int =
  let grid = mapIt(xs, map(it.toSeq(), proc (c: char): int = parseInt($c)))
  let lows = lowpoints(grid)
  lows.foldl(a + grid[b.y][b.x] + 1, 0)

proc basin(xs: seq[seq[int]], x: tuple[x: int, y: int], points: var HashSet[tuple[x: int, y: int]]) =
  points.incl(x)
  for point in neighbours(xs, x.x, x.y):
    if xs[point.y][point.x] == 9:
      continue

    if point notin points:
      basin(xs, point, points)

proc part2(xs: seq[string]): int =
  let grid = mapIt(xs, map(it.toSeq(), proc (c: char): int = parseInt($c)))
  let lows = lowpoints(grid)

  let basins = collect(newSeq):
    for point in lows:
      var points = initHashSet[tuple[x: int, y: int]]()
      basin(grid, point, points)
      len(points)
  foldl(sorted(basins)[basins.high - 2 .. basins.high], a * b, 1)

let f = strip(readFile("in09")).splitLines()
echo f.part1()
echo f.part2()
