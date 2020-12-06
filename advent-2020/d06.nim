import sets
import sequtils
import strutils

iterator groups(xs: seq[string]): seq[string] =
  var group: seq[string] = @[]
  for line in xs:
    if line.len == 0:
      yield group
      group = @[]
      continue
    group &= split(line, ' ')
  yield group

proc part1(xs: seq[string]): int =
  for group in groups(xs):
    result += foldl(map(group, proc(x: string): HashSet[char] = toHashSet(x)), union(a, b)).len

proc part2(xs: seq[string]): int =
  for group in groups(xs):
    result += foldl(map(group, proc(x: string): HashSet[char] = toHashSet(x)), intersection(a, b)).len

let f = strip(readFile("in06")).splitLines()
echo f.part1()
echo f.part2()
