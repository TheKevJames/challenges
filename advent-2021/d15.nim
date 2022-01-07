import std/heapqueue
import std/sequtils
import std/strutils
import std/sugar
import std/tables

proc neighbours(xs: seq[seq[int]], x: int, y: int): seq[tuple[x: int, y: int]] =
  if x > 0:
    result.add((x: x - 1, y: y))
  if y > 0:
    result.add((x: x, y: y - 1))
  if y < xs.high:
    result.add((x: x, y: y + 1))
  if x < xs[0].high:
    result.add((x: x + 1, y: y))

iterator follow(cameFrom: Table[tuple[x: int, y: int], tuple[x: int, y: int]],
                dst: tuple[x: int, y: int]): tuple[x: int, y: int] =
  var next: tuple[x: int, y: int]
  var current = dst

  while current != (x: 0, y: 0):
    next = cameFrom[current]
    yield current
    current = next

proc manhatten(puzzle: seq[seq[int]], x: int, y: int): int =
  abs(puzzle[0].high - x) + abs(puzzle.high - y)

proc score(gScore: seq[seq[int]], point: tuple[x: int, y: int]): int =
  # manhatten unnecessary
  # gScore[point.y][point.x]
  gScore[point.y][point.x] + manhatten(gScore, point.x, point.y)

proc astar(puzzle: seq[seq[int]]): seq[tuple[x: int, y: int]] =
  var openSet = @[(prio: 0, point: (x: 0, y: 0))].toHeapQueue
  var cameFrom: Table[tuple[x: int, y: int], tuple[x: int, y: int]]

  var gScore = newSeqWith(len(puzzle), newSeqWith(len(puzzle[0]), high(int)))
  gScore[0][0] = 0

  while len(openSet) != 0:
    var current = openSet.pop().point
    if current == (x: puzzle[0].high, y: puzzle.high):
      return toSeq(follow(cameFrom, (x: puzzle[0].high, y: puzzle.high)))

    for n in neighbours(puzzle, current.x, current.y):
      var tentativeScore = gScore[current.y][current.x] + puzzle[current.y][current.x]
      if tentativeScore < gScore[n.y][n.x]:
        cameFrom[n] = current
        gScore[n.y][n.x] = tentativeScore
        openSet.push((prio: score(gScore, n), point: n))

  echo "Err"
  return

proc cost(puzzle: seq[seq[int]], path: seq[tuple[x: int, y: int]]): int =
  path.foldl(a + puzzle[b.y][b.x], 0)

proc part1(xs: seq[string]): int =
  let puzzle = xs.map((s) => toSeq(s).map((c) => parseInt($c)))
  let path = astar(puzzle)
  cost(puzzle, path)

proc shift(row: seq[int], value: int): seq[int] =
  row.map((x) => x + value).map((x) => (if x > 9: x mod 9 else: x))

proc expand(xs: seq[seq[int]]): seq[seq[int]] =
  for row in xs:
    result.add(row & shift(row, 1) & shift(row, 2) & shift(row, 3) & shift(row, 4))

  for i in 1 .. 4:
    for row in result[0 .. xs.high]:
      result.add(shift(row, i))

proc part2(xs: seq[string]): int =
  let puzzle = xs.map((s) => toSeq(s).map((c) => parseInt($c))).expand()
  let path = astar(puzzle)
  cost(puzzle, path)

let f = strip(readFile("in15")).splitLines()
echo f.part1()
echo f.part2()
