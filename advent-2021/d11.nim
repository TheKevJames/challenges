import std/sequtils
import std/strutils
import std/sugar

type
  Octo* = object
    energy: int
    flashed: bool

proc newOcto(energy: int): Octo =
  Octo(energy: energy, flashed: false)

proc parse(xs: seq[string]): seq[seq[Octo]] =
  xs.map((x) => toSeq(x).map((o) => newOcto(parseInt($o))))

proc neighbours(xss: seq[seq[Octo]], x: int, y: int): seq[tuple[x: int, y: int]] =
  if x > 0:
    result.add((x: x - 1, y: y))
    if y > 0:
      result.add((x: x - 1, y: y - 1))
    if y < xss.high:
      result.add((x: x - 1, y: y + 1))
  if y > 0:
    result.add((x: x, y: y - 1))
  if y < xss.high:
    result.add((x: x, y: y + 1))
  if x < xss[0].high:
    result.add((x: x + 1, y: y))
    if y > 0:
      result.add((x: x + 1, y: y - 1))
    if y < xss.high:
      result.add((x: x + 1, y: y + 1))

proc tick(xss: var seq[seq[Octo]]): int =
  for i in 0 .. xss.high:
    for j in 0 .. xss[0].high:
      xss[i][j].energy += 1

  var grid = deepCopy(xss)
  while true:
    for i in 0 .. grid.high:
      for j in 0 .. grid[0].high:
        let x = grid[i][j]
        if not x.flashed and x.energy > 9:
          grid[i][j].flashed = true
          result += 1
          for n in neighbours(grid, j, i):
            grid[n.y][n.x].energy += 1

    if xss == grid:
      break

    xss = grid

  for i in 0 .. xss.high:
    for j in 0 .. xss[0].high:
      let x = xss[i][j]
      if x.flashed:
        xss[i][j] = newOcto(0)

proc part1(xs: seq[string]): int =
  var grid = parse(xs)
  let flashes = collect(newSeq):
    for i in 0 ..< 100:
      tick(grid)
  flashes.foldl(a + b)

proc part2(xs: seq[string]): int =
  let target = len(xs) * len(xs[0])

  var grid = parse(xs)
  for i in 1 ..< 999:
    if tick(grid) == target:
      return i

let f = strip(readFile("in11")).splitLines()
echo f.part1()
echo f.part2()
