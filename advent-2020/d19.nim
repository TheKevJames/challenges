import pegs
import sequtils
import strformat
import strscans
import strutils

proc parse(xs: seq[string], recurse8 = 0, recurse11 = 0): (string, seq[string]) =
  var i: int
  var s: string
  var rules = @["Start <- ^Z0$"]
  var msgs: seq[string]

  for x in xs:
    if scanf(x, "$i: $+", i, s):
      s = join(map(s.split(),
                   proc(x: string): string =
                     case x
                     of "|": "/"
                     of "\"a\"": "'a'"
                     of "\"b\"": "'b'"
                     else: &"Z{x}"), " ")
      if i == 8 and recurse8 > 0:
        # s = "Z42 / Z42 Z8"
        s = join(newSeqWith(recurse8, "Z42"), " ")
        # TODO: would be way faster, PEGs don't backtrack properly
        # s = join(map(toSeq(countup(1, recurse8)),
        #              proc(i: int): string = join(newSeqWith(i, "Z42"), " ")), " / ")
      elif i == 11 and recurse11 > 0:
        # s = "Z42 Z31 / Z42 Z11 Z31"
        s = join(map(toSeq(countup(1, recurse11)),
                     proc(i: int): string =
                       join(newSeqWith(i, "Z42"), " ") & " " & join(newSeqWith(i, "Z31"), " ")), " / ")
      rules.add(&"Z{i} <- {s}")
    elif x.len > 0:
      msgs.add(x)

  (join(rules, "\n"), msgs)

proc part1(xs: seq[string]): int =
  let (rules, msgs) = parse(xs)
  for msg in msgs:
    if msg =~ peg(rules):
      result += 1

proc part2(xs: seq[string]): int =
  var hits: set[int16]
  for i in 1 .. 25:
    let (rules, msgs) = parse(xs, recurse8=i, recurse11=4)
    for i, msg in msgs:
      if i.int16 in hits:
        continue

      if msg =~ peg(rules):
        hits.incl(i.int16)

  hits.len

let f = strip(readFile("in19")).splitLines()
echo f.part1()
echo f.part2()
