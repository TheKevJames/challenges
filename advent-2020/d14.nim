import math
import sequtils
import strscans
import strutils
import tables

proc part1(xs: seq[string]): int =
  var mask: string
  var maskAnd, maskOr: int
  var key, val: int
  var data = initTable[int, int]()

  for x in xs:
    if scanf(x, "mask = $+", mask):
      maskAnd = fromBin[int](mask.replace('X', '1'))
      maskOr = fromBin[int](mask.replace('X', '0'))
    elif scanf(x, "mem[$i] = $i", key, val):
      let masked = (val or maskOr) and maskAnd
      data[key] = masked
  foldl(toSeq(data.values), a + b)

iterator applyFloating(bin: string, mask: string): int =
  let idxs = map(filter(toSeq(mask.pairs), proc(x: tuple[key: int, val: char]): bool = x.val == 'X'),
                 proc(x: tuple[key: int, val: char]): int = x.key)
  for replaces in countup(0, 2 ^ idxs.len - 1):
    let target = toBin(replaces, idxs.len)
    var applied = bin
    for i, idx in idxs:
      applied[idx] = target[i]
    yield fromBin[int](applied)

proc part2(xs: seq[string]): int =
  var mask: string
  var maskOr: int
  var key, val: int
  var data = initTable[int, int]()

  for x in xs:
    if scanf(x, "mask = $+", mask):
      maskOr = fromBin[int](mask.replace('X', '0'))
    elif scanf(x, "mem[$i] = $i", key, val):
      let masked = key or maskOr
      for key in applyFloating(toBin(masked, 36), mask):
        data[key] = val
  foldl(toSeq(data.values), a + b)

let f = strip(readFile("in14")).splitLines()
echo f.part1()
echo f.part2()
