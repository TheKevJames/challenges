import sequtils
import strscans
import strutils

type Line = tuple[x1: int, y1: int, x2: int, y2: int]

iterator parse(xs: seq[string]): Line =
  for x in xs:
    var x1, x2, y1, y2: int
    discard scanf(x, "$i,$i -> $i,$i", x1, y1, x2, y2)
    yield (x1: x1, y1: y1, x2: x2, y2: y2)

iterator flatten*[T](xss: seq[seq[T]]): T =
  for xs in xss:
    for x in xs:
      yield x

proc part1(xs: seq[string]): int =
  let cardinals = filter(toSeq(parse(xs)), proc (l: Line): bool = l.x1 == l.x2 or l.y1 == l.y2)

  let height = cardinals.foldl(max(@[a, b.y1, b.y2]), 0) + 1
  let width = cardinals.foldl(max(@[a, b.x1, b.x2]), 0) + 1

  var board = newSeqWith(height, newSeq[int](width))
  for line in cardinals:
    if line.x1 == line.x2:
      for i in min(@[line.y1, line.y2]) .. max(@[line.y1, line.y2]):
        inc board[i][line.x1]
    else:
      for i in min(@[line.x1, line.x2]) .. max(@[line.x1, line.x2]):
        inc board[line.y1][i]

  len(filter(toSeq(flatten(board)), proc (x: int): bool = x > 1))

iterator between(l: Line): tuple[x: int, y: int] =
  if l.x1 < l.x2:
    for i in 0 .. l.x2 - l.x1:
      if l.y1 < l.y2:
        yield (x: l.x1 + i, y: l.y1 + i)
      else:
        yield (x: l.x1 + i, y: l.y1 - i)
  else:
    for i in 0 .. l.x1 - l.x2:
      if l.y1 < l.y2:
        yield (x: l.x1 - i, y: l.y1 + i)
      else:
        yield (x: l.x1 - i, y: l.y1 - i)

proc part2(xs: seq[string]): int =
  let lines = toSeq(parse(xs))

  let height = lines.foldl(max(@[a, b.y1, b.y2]), 0) + 1
  let width = lines.foldl(max(@[a, b.x1, b.x2]), 0) + 1

  var board = newSeqWith(height, newSeq[int](width))
  for line in lines:
    if line.x1 == line.x2:
      for i in min(@[line.y1, line.y2]) .. max(@[line.y1, line.y2]):
        inc board[i][line.x1]
    elif line.y1 == line.y2:
      for i in min(@[line.x1, line.x2]) .. max(@[line.x1, line.x2]):
        inc board[line.y1][i]
    else:
      for point in between(line):
        inc board[point.y][point.x]

  len(filter(toSeq(flatten(board)), proc (x: int): bool = x > 1))

let f = strip(readFile("in05")).splitLines()
echo f.part1()
echo f.part2()
