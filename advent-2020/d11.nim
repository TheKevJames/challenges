import sequtils
import strutils

proc adjacentOccupancy(xs: seq[string], i: int, j: int): int =
  # TODO: be less awful
  if i > 0:
    if j > 0:
      result += int(xs[i - 1][j - 1] == '#')
    result += int(xs[i - 1][j] == '#')
    if j < high(xs[0]):
      result += int(xs[i - 1][j + 1] == '#')
  if j > 0:
    result += int(xs[i][j - 1] == '#')
  if j < high(xs[0]):
    result += int(xs[i][j + 1] == '#')
  if i < high(xs):
    if j > 0:
      result += int(xs[i + 1][j - 1] == '#')
    result += int(xs[i + 1][j] == '#')
    if j < high(xs[0]):
      result += int(xs[i + 1][j + 1] == '#')

proc losOccupancy(xs: seq[string], i: int, j: int): int =
  # TODO: come on, man
  for off in countUp(1, min(i, j)):
    if xs[i - off][j - off] != '.':
      result += int(xs[i - off][j - off] == '#')
      break
  for off in countUp(1, min(i, high(xs[0]) - j)):
    if xs[i - off][j + off] != '.':
      result += int(xs[i - off][j + off] == '#')
      break
  for off in countUp(1, min(high(xs) - i, high(xs[0]) - j)):
    if xs[i + off][j + off] != '.':
      result += int(xs[i + off][j + off] == '#')
      break
  for off in countUp(1, min(high(xs) - i, j)):
    if xs[i + off][j - off] != '.':
      result += int(xs[i + off][j - off] == '#')
      break

  for off in countUp(1, i):
    if xs[i - off][j] != '.':
      result += int(xs[i - off][j] == '#')
      break
  for off in countUp(1, high(xs) - i):
    if xs[i + off][j] != '.':
      result += int(xs[i + off][j] == '#')
      break

  for off in countUp(1, j):
    if xs[i][j - off] != '.':
      result += int(xs[i][j - off] == '#')
      break
  for off in countUp(1, high(xs[0]) - j):
    if xs[i][j + off] != '.':
      result += int(xs[i][j + off] == '#')
      break

proc step(xs: seq[string], style: proc(a: seq[string], b,c: int): int,
          threshold: int): seq[string] =
  for i, x in xs.pairs:
    var vals: string
    for j, c in x.pairs:
      if c == 'L' and style(xs, i, j) == 0:
        vals.add('#')
      elif c == '#' and style(xs, i, j) >= threshold:
        vals.add('L')
      else:
        vals.add(c)
    result.add(vals)

proc part1(xs: seq[string]): int =
  var prev = xs
  while true:
    let next = step(prev, adjacentOccupancy, 4)
    if prev == next:
      return next.foldl(a + count(b, '#'), 0)
    prev = next

proc part2(xs: seq[string]): int =
  var prev = xs
  while true:
    let next = step(prev, losOccupancy, 5)
    if prev == next:
      return next.foldl(a + count(b, '#'), 0)
    prev = next

let f = strip(readFile("in11")).splitLines()
echo f.part1()
echo f.part2()
