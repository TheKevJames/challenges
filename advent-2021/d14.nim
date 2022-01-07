import std/algorithm
import std/sequtils
import std/sets
import std/strscans
import std/strutils
import std/sugar
import std/tables

proc parse(xs: seq[string]): tuple[polymer: string, rules: seq[tuple[src: string, dst: string]]] =
  result.polymer = xs[0]
  for x in xs[1 .. xs.high]:
    var src, dst: string
    if scanf(x, "$w -> $w", src, dst):
      result.rules.add((src: src, dst: dst))

iterator ops(polymer: string,
             rules: seq[tuple[src: string, dst: string]]): tuple[idx: int, dst: string] =
  for r in rules:
    var idx = polymer.find(r.src)
    while idx != -1:
      yield (idx: idx, dst: r.dst)
      idx = polymer.find(r.src, idx + 1)

proc tick(polymer: string, rules: seq[tuple[src: string, dst: string]]): string =
  result = polymer
  for replace in toSeq(ops(polymer, rules)).sorted(Descending):
    result.insert(replace.dst, replace.idx + 1)

proc part1(xs: seq[string]): int =
  let data = parse(xs)
  var polymer = data.polymer
  for i in 1 .. 10:
    polymer = tick(polymer, data.rules)
  let counts = toCountTable(polymer)
  largest(counts).val - smallest(counts).val

iterator windowed*[T](xs: seq[T], size: Positive): seq[T] =
  var i: int
  while i + size <= len(xs):
    yield xs[i ..< i + size]
    inc i

proc tick(box: tuple[polymer: CountTable[char], pairs: CountTable[string]],
          rules: seq[tuple[src: string, dst: string]]): tuple[polymer: CountTable[char], pairs: CountTable[string]] =
  result.polymer = box.polymer
  result.pairs = box.pairs
  for rule in rules:
    let count = box.pairs[rule.src]
    result.polymer[rule.dst[0]] = result.polymer[rule.dst[0]] + count
    result.pairs[rule.src[0] & rule.dst] = result.pairs[rule.src[0] & rule.dst] + count
    result.pairs[rule.dst & rule.src[1]] = result.pairs[rule.dst & rule.src[1]] + count
    result.pairs[rule.src] = result.pairs[rule.src] - count

proc part2(xs: seq[string]): int =
  let data = parse(xs)
  let pairs = toSeq(windowed(data.polymer.toSeq(), 2)).map((cs) => cs.join)
  var box = (polymer: data.polymer.toCountTable, pairs: pairs.toCountTable)
  for i in 1 .. 40:
    box = tick(box, data.rules)
  largest(box.polymer).val - smallest(box.polymer).val

let f = strip(readFile("in14")).splitLines()
echo f.part1()
echo f.part2()
