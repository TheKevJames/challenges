import sets
import sequtils
import strutils

proc hasPair(haystack: seq[int], needle: int): bool =
  for i in haystack:
    if (needle - i) in haystack:
      return true
  false

proc findInvalid(xs: seq[int]): int =
  var recent: seq[int] = xs[0 .. 24]
  var idx = 0
  for x in xs[25 .. high(xs)]:
    if not hasPair(recent, x):
      return x
    recent[idx] = x
    idx = (idx + 1) mod 25

proc part1(xs: seq[string]): int =
  findInvalid(map(xs, parseInt))

proc part2(xs: seq[string]): int =
  let data = map(xs, parseInt)
  let target = findInvalid(data)
  for i, x in data:
    var acc = x
    for j, y in data[i + 1 .. high(data)]:
      acc += y
      if acc == target:
        let options = data[i .. i+j+1]
        return min(options) + max(options)
      elif acc > target:
        break

let f = strip(readFile("in09")).splitLines()
echo f.part1()
echo f.part2()
