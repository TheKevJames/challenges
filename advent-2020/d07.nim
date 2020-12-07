import sequtils
import sets
import strscans
import strutils
import tables

type Item = tuple[item: string, count: int]
type Rules = Table[string, seq[Item]]  # parent -> children
type InvRules = Table[string, HashSet[string]]  # child -> parents

proc toPair(x: string): tuple[k,v: string] =
  discard scanf(x, "$+ contain $+", result.k, result.v)

proc parseKey(x: string): string =
  discard scanf(x, "$* bag", result)

proc parseItem(x: string): Item =
  var count, item: string
  discard scanf(x, "$* $*", count, item)
  result.count = parseInt(count.replace("no", "0"))
  result.item = parseKey(item)

proc getRules(xs: seq[string]): Rules =
  for x in xs:
    let (key, tail) = toPair(x)
    result[parseKey(key)] = map(split(tail, ", "), parseItem)

proc getInvRules(xs: seq[string]): InvRules =
  for x in xs:
    let (key, tail) = toPair(x)
    for v in map(split(tail, ", "), parseItem):
      incl(mgetOrPut(result, v.item, initHashSet[string]()), parseKey(key))

proc uniqueParents(rules: InvRules, child: string,
                   seen: HashSet[string] = initHashSet[string]()): HashSet[string] =
  let parents = getOrDefault(rules, child) - seen
  # TODO: two problems here:
  # * not backpropogating the `seen` values, so processing the same things multiple times
  # * HashSet[string] operations seem to be slow as fuck?
  foldl(parents, a + uniqueParents(rules, b, a + seen + parents), parents)

proc countChildren(rules: Rules, parent: string): int =
  for child in rules[parent]:
    if child.count > 0:
      result += (1 + countChildren(rules, child.item)) * child.count

proc part1(xs: seq[string]): int =
  uniqueParents(getInvRules(xs), "shiny gold").len

proc part2(xs: seq[string]): int =
  countChildren(getRules(xs), "shiny gold")

let f = strip(readFile("in07")).splitLines()
echo f.part1()
echo f.part2()
