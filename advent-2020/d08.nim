import sequtils
import sets
import strscans
import strformat
import strutils

proc run(xs: seq[string], visited: var HashSet[int], acc: var int): bool =
  var op: string
  var val: int

  acc = 0
  visited.clear()

  incl(visited, high(xs) + 1)
  var idx = 0
  while true:
    if containsOrIncl(visited, idx):
      return idx > high(xs)

    discard scanf(xs[idx], "$w $i", op, val)
    if op == "acc":
      acc += val
      idx += 1
    elif op == "jmp":
      idx += val
    elif op == "nop":
      idx += 1

proc part1(xs: seq[string]): int =
  var visited = initHashSet[int]()
  discard run(xs, visited, result)

proc part2(xs: seq[string]): int =
  var acc = 0
  var mutations = initHashSet[int]()
  discard run(xs, mutations, acc)

  var op: string
  var val: int
  var visited = initHashSet[int]()
  for mut in mutations:
    discard scanf(xs[mut], "$w $i", op, val)
    if op == "acc":
      continue

    let mutation = (if op == "jmp": "nop" else: "jmp")
    let newXs = concat(xs[0 .. mut - 1], @[&"{mutation} {val}"],
                       xs[mut + 1 .. high(xs)])
    if run(newXs, visited, acc):
      return acc

let f = strip(readFile("in08")).splitLines()
echo f.part1()
echo f.part2()
