import std/sequtils
import std/strutils
import std/tables

proc part1(xs: seq[string]): int =
  for x in xs:
    let numbers = x.split("|")[1].splitWhitespace()
    result += len(filter(numbers, proc (s: string): bool = len(s) in {2, 3, 4, 7}))

proc newLookup(): Table[char, set[char]] =
  let letters = {'a', 'b', 'c', 'd', 'e', 'f', 'g'}
  for x in letters:
    result[x] = letters

proc solve(t: Table[char, set[char]], reading: string): seq[string] =
  for x in reading:
    if t[x] == {'c', 'f'}:
      result.add("cf")
    elif t[x] == {'a', 'c', 'f'}:
      result.add("a")
    elif t[x] == {'b', 'c', 'd', 'f'}:
      result.add("bd")
    else:
      result.add("x")

proc part2(xs: seq[string]): int =
  for x in xs:
    let line = x.split("|")
    var lookup = newLookup()

    let data = line[0].splitWhitespace()
    for datum in data:
      if len(datum) == 2:  # 1
        for x in datum:
          lookup[x] = lookup[x] * {'c', 'f'}
      elif len(datum) == 3:  # 7
        for x in datum:
          lookup[x] = lookup[x] * {'a', 'c', 'f'}
      elif len(datum) == 4:  # 4
        for x in datum:
          lookup[x] = lookup[x] * {'b', 'c', 'd', 'f'}

    let readings = line[1].splitWhitespace()
    var fixed: seq[int]
    for reading in readings:
      if len(reading) == 2:
        fixed.add(1)
      elif len(reading) == 3:
        fixed.add(7)
      elif len(reading) == 4:
        fixed.add(4)
      elif len(reading) == 5:
        let reduced = solve(lookup, reading)
        if count(reduced, "cf") == 2:
          # 3 -> acdfg (no be)
          fixed.add(3)
        elif count(reduced, "bd") == 2:
          # 5 -> abdfg (no ce)
          fixed.add(5)
        else:
          # 2 -> acdeg (no bf)
          fixed.add(2)
      elif len(reading) == 6:
        let reduced = solve(lookup, reading)
        if count(reduced, "cf") != 2:
          # 6 -> abdefg (no c)
          fixed.add(6)
        elif count(reduced, "bd") == 2:
          # 9 -> abcdfg (no e)
          fixed.add(9)
        else:
          # 0 -> abcefg (no d)
          fixed.add(0)
      elif len(reading) == 7:
        fixed.add(8)

    result += (fixed[0] * 1000 + fixed[1] * 100 + fixed[2] * 10 + fixed[3])

let f = strip(readFile("in08")).splitLines()
echo f.part1()
echo f.part2()
