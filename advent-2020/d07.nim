import sequtils
import sets
import strutils
import tables

type Item = tuple[item: string, count: int]
type Rules = Table[string, seq[Item]]

proc toPair(x: string): tuple[k,v: string] =
  (result.k, result.v) = split(x, " contain ")

proc parseKey(x: string): string =
  split(x, " bag")[0]

proc parseItem(x: string): Item =
  var count, item: string
  (count, item) = split(x, " ", 1)
  result.count = parseInt(count.replace("no", "0"))
  result.item = parseKey(item)

proc getRules(xs: seq[string]): Rules =
  for x in xs:
    let (key, tail) = toPair(x)
    let values = split(tail, ", ")
    result[parseKey(key)] = map(values, parseItem)

iterator getParents(rules: Rules, child: string): string =
  for k, v in rules.pairs:
    if child in map(v, proc(x: Item): string = x.item):
      yield k

# TODO: clean this up with foldl magic
proc uniqueParents(rules: Rules, child: string,
                   seen: HashSet[string] = initHashSet[string]()): seq[string] =
  let parents = toHashSet(toSeq(getParents(rules, child)))
  for parent in (parents - seen):
    # TODO: some sort of += equivalent? This'd be great as a few yields, but
    # Nim doesn't support recursive iterators :(
    result = concat(result, @[parent], uniqueParents(rules, parent, seen + parents))

proc part1(xs: seq[string]): int =
  uniqueParents(getRules(xs), "shiny gold").len

proc countChildren(rules: Rules, parent: string): int =
  for child in rules[parent]:
    if child.count > 0:
      result += child.count
      result += child.count * countChildren(rules, child.item)

proc part2(xs: seq[string]): int =
  countChildren(getRules(xs), "shiny gold")

let f = strip(readFile("in07")).splitLines()
echo f.part1()
echo f.part2()
