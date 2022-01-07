import std/algorithm
import std/sequtils
import std/strutils
import std/sugar
import std/tables

let closing = {'(': ')', '[': ']', '{': '}', '<': '>'}.toTable

proc chunks(x: string, i: int = 0): tuple[i: int, v: int] =
  let me = x[i]
  var idx = i + 1

  while x[idx] in toSeq(closing.keys()):
    let nested = chunks(x, idx)
    if nested.v != 0:
      return nested
    idx = nested.i

  if x[idx] == closing[me]:
    # shouldn't this be a bug? what if the line starts with "()"?
    return (idx + 1, 0)

  case x[idx]
  of ')': (i: idx, v: 3)
  of ']': (i: idx, v: 57)
  of '}': (i: idx, v: 1197)
  of '>': (i: idx, v: 25137)
  else:
    # incomplete
    (i: idx, v: 0)

proc part1(xs: seq[string]): int =
  xs.map((x) => chunks(x).v).foldl(a + b)

proc fix(x: string, i: int = 0): tuple[i: int, v: int] =
  let me = x[i]
  var idx = i + 1
  var res = 0

  while x[idx] in toSeq(closing.keys()):
    let nested = fix(x, idx)
    if nested.v != 0:
      res *= 5
      res += nested.v
    idx = nested.i

  if x[idx] == closing[me]:
    return (idx + 1, 0)

  case closing[me]
  of ')': (i: idx, v: res * 5 + 1)
  of ']': (i: idx, v: res * 5 + 2)
  of '}': (i: idx, v: res * 5 + 3)
  of '>': (i: idx, v: res * 5 + 4)
  else:
    echo "Err"
    (i: idx, v: 0)

proc part2(xs: seq[string]): int =
  let incomplete = xs.filter((x) => chunks(x).v == 0)
  let scores = collect(newSeq):
    for x in incomplete:
      var res = fix(x)
      while res.i < x.high:
        res = fix(x, res.i)
      res.v

  sorted(scores)[scores.high div 2]

let f = strip(readFile("in10")).splitLines()
echo f.part1()
echo f.part2()
