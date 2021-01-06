import sequtils
import sets
import strscans
import strutils
import tables

proc parse(xs: seq[string]): (Table[string, tuple[a,b,c,d: int]], seq[seq[int]]) =
  var rules = initTable[string, tuple[a,b,c,d: int]]()
  var tickets: seq[seq[int]]

  var s: string
  var a,b,c,d: int

  for x in xs:
    if scanf(x, "$+: $i-$i or $i-$i", s, a, b, c, d):
      rules[s] = (a, b, c, d)
    elif x.len > 0 and x[0].isDigit:
      tickets.add(map(x.split(','), parseInt))

  (rules, tickets)

iterator invalidFields(rules: Table[string, tuple[a,b,c,d: int]], ticket: seq[int]): int =
  for field in ticket:
    var valid = false
    for rule in rules.values:
      if (rule.a <= field and field <= rule.b) or (rule.c <= field and field <= rule.d):
        valid = true
        break

    if not valid:
      yield field

proc solve(rules: Table[string, tuple[a,b,c,d: int]], tickets: seq[seq[int]]): seq[string] =
  var assoc = newSeqWith(rules.len, initHashSet[string]())

  for ticket in tickets:
    for i, field in ticket:
      var candidates = initHashSet[string]()
      for name, rule in rules:
        if (rule.a <= field and field <= rule.b) or (rule.c <= field and field <= rule.d):
          candidates.incl(name)

      if assoc[i].len == 0:
        assoc[i] = candidates
      else:
        assoc[i] = assoc[i].intersection(candidates)

  var known = newSeqWith(rules.len, "")

  while any(known, proc(x: string): bool = x == ""):
    for i, cands in assoc.mpairs:
      if cands.len == 1:
        known[i] = cands.pop
      else:
        cands.excl(toHashSet(known))

  known

proc part1(xs: seq[string]): int =
  let (rules, tickets) = parse(xs)

  for ticket in tickets[1 .. high(tickets)]:
    for field in invalidFields(rules, ticket):
      result += field

proc part2(xs: seq[string]): int =
  let (rules, tickets) = parse(xs)

  let valids = filter(tickets[1 .. high(tickets)],
                      proc(x: seq[int]): bool = toSeq(invalidFields(rules, x)).len == 0)

  let fieldMap = solve(rules, valids)

  result = 1
  for i, field in tickets[0]:
    if fieldMap[i].startswith("departure"):
      result *= field

let f = strip(readFile("in16")).splitLines()
echo f.part1()
echo f.part2()
