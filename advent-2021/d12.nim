import std/sequtils
import std/sets
import std/strscans
import std/strutils
import std/sugar
import std/tables

type Caves = Table[string, HashSet[string]]

proc parse(xs: seq[string]): Caves =
  for x in xs:
    var lhs, rhs: string
    discard scanf(x, "$w-$w", lhs, rhs)
    result.mgetOrPut(lhs, initHashSet[string]()).incl(rhs)
    result.mgetOrPut(rhs, initHashSet[string]()).incl(lhs)

proc visit(caves: Caves, visited: HashSet[string] = toHashSet(["start"]), loc: string = "start"): int =
  if loc == "end":
    return 1

  for next in caves[loc]:
    if next == "start":
      continue
    if next.all(isLowerAscii) and next in visited:
      continue

    result += visit(caves, visited + toHashSet([next]), next)

proc visitTwice(caves: Caves,
                reenter: string,
                visited: seq[string] = @["start"],
                loc: string = "start"): int =
  if loc == "end":
    # avoid double-counting
    if visited.count(reenter) == 2:
      return 1
    else:
      return 0

  for next in caves[loc]:
    if next == "start":
      continue
    if next.all(isLowerAscii) and next in visited:
      if next != reenter or visited.count(reenter) == 2:
        continue

    result += visitTwice(caves, reenter, visited & next, next)

proc part1(xs: seq[string]): int =
  visit(parse(xs))

proc part2(xs: seq[string]): int =
  let caves = parse(xs)
  let reentry = filter(toSeq(caves.keys()), (x) => x.all(isLowerAscii))
  reentry.map((x) => visitTwice(caves, x)).foldl(a + b) + visit(caves)

let f = strip(readFile("in12")).splitLines()
echo f.part1()
echo f.part2()
