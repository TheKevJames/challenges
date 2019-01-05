import intsets
import strutils

proc part1(xs: seq[string]): int =
  for x in xs:
    result += parseInt(x)

proc part2(xs: seq[string]): int =
  var seen = initIntSet()
  var curr = 0
  seen.incl(curr)

  while true:
    for x in xs:
      curr += parseInt(x)
      if seen.contains(curr):
        return curr

      seen.incl(curr)

let f = strip(readFile("in01")).splitLines()
echo f.part1()
echo f.part2()
