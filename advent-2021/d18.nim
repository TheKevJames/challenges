import std/algorithm
import std/heapqueue
import std/options
import std/sequtils
import std/sets
import std/strformat
import std/strscans
import std/strutils
import std/sugar
import std/tables

type
  NodeKind = enum Pair, Value
  Node = ref object
    case kind: NodeKind
    of Pair:
      lhs, rhs: Node
    of Value:
      val: int

proc `$`*(n: Node): string =
  case n.kind
  of Pair: fmt"[{$n.lhs},{$n.rhs}]"
  of Value: $n.val

proc add(lhs: Node, rhs: Node): Node = Node(kind: Pair, lhs: lhs, rhs: rhs)

#[
proc parseInner(s: string, i: int = 0): (Option[Num], int) =
  var idx = i
  case s[idx]
  of '[':
    var n = Num()
    (n.lhs, idx) = parseInner(s, idx + 1)
    (n.rhs, idx) = parseInner(s, idx + 1)
    return (some(n), idx + 1)
  of ',':
    return parseInner(s, idx + 1)
  of '0'..'9':
    return (some(Num(val: some(parseInt($s[idx])))), idx + 1)
  else:
    echo "Err bad input char: ", s[idx]
    assert false

proc parse(s: string): Num = parseInner(s)[0].get()

proc part1(xs: seq[string]): int =
  for x in xs:
    let n = parse(x)
    echo n
    echo findChildren(n)
    echo reduce(n)
  0

proc part2(xs: seq[string]): int =
  0

# let f = strip(readFile("in18")).splitLines()
# let f = @["[1,[2,3]]"]
# let f = @["[[[[1,3],[5,3]],[[1,3],[8,7]]],[[[4,9],[6,9]],[[8,2],[7,3]]]]"]
let f = @["[[[[[9,8],1],2],3],4]"]
echo f.part1()
echo f.part2()
]#
