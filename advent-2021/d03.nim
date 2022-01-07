import sequtils
import strutils

iterator cols(xs: seq[string]): seq[char] =
  for i in xs[0].low .. xs[0].high:
    var col: seq[char]
    for x in xs:
      col.add(x[i])
    yield col

proc gamma(xs: seq[string]): string =
  for x in cols(xs):
    # off by one?
    # result.add(if count(x, '1') >= int(len(x) / 2): '1' else: '0')
    result.add(if count(x, '1') >= count(x, '0'): '1' else: '0')

proc part1(xs: seq[string]): int =
  var val = fromBin[int](gamma(xs))
  # len(xs[0]) == 12, need to nuke the top four bits
  val * ((not val.uint16) - fromBin[uint16]("1111000000000000")).int

proc findrating(xs: seq[string], flip: bool = false): int =
  var candidates = xs
  for i in 0 .. candidates[0].high:
    var target = gamma(candidates)[i]
    if flip:
      target = (if target == '0': '1' else: '0')
    candidates = filter(candidates, proc(x: string): bool = x[i] == target)
    if len(candidates) == 1:
      break

  fromBin[int](candidates[0])

proc part2(xs: seq[string]): int =
  var oxygen = findrating(xs, false)
  var carbon = findrating(xs, true)

  oxygen * carbon

let f = strip(readFile("in03")).splitLines()
echo f.part1()
echo f.part2()
