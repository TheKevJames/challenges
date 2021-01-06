# TODO: pegs is the "right answer" here, if I could figure out how it's supposed to work
import sequtils
import strutils

proc parse(x: string, precedence: bool): int =
  var ops: seq[char]
  var vals: seq[int]

  proc eval() =
    case ops.pop
    of '+': vals.add(vals.pop + vals.pop)
    of '*': vals.add(vals.pop * vals.pop)
    else: discard

  for c in x:
    case c
    of ' ': discard
    of '(': ops.add(c)
    of ')':
      while ops[^1] != '(':
        eval()
      discard ops.pop
    of '+', '*':
      if precedence:
        while ops.len > 0 and ops[^1] != '(' and c == '*' and ops[^1] == '+':
          eval()
      else:
        while ops.len > 0 and ops[^1] != '(':
          eval()
      ops.add(c)
    else:
      vals.add(c.ord - '0'.ord)

  while ops.len > 0:
    eval()
  vals.pop

proc part1(xs: seq[string]): int =
  xs.foldl(a + parse(b, false), 0)

proc part2(xs: seq[string]): int =
  xs.foldl(a + parse(b, true), 0)

let f = strip(readFile("in18")).splitLines()
echo f.part1()
echo f.part2()
