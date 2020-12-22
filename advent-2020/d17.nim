# TODO: be better than this
import sequtils
import strutils

proc activeNeighbours(state: seq[seq[seq[char]]], i: int, j: int, k: int): int =
  for a in countup(i - 1, i + 1):
    if a < 0 or a > high(state):
      continue
    for b in countup(j - 1, j + 1):
      if b < 0 or b > high(state[0]):
        continue
      for c in countup(k - 1, k + 1):
        if c < 0 or c > high(state[0][0]):
          continue
        if a == i and b == j and c == k:
          continue

        result += int(state[a][b][c] == '#')

proc hyperactiveNeighbours(state: seq[seq[seq[seq[char]]]], i: int, j: int, k: int, m: int): int =
  for a in countup(i - 1, i + 1):
    if a < 0 or a > high(state):
      continue
    for b in countup(j - 1, j + 1):
      if b < 0 or b > high(state[0]):
        continue
      for c in countup(k - 1, k + 1):
        if c < 0 or c > high(state[0][0]):
          continue
        for d in countup(m - 1, m + 1):
          if d < 0 or d > high(state[0][0][0]):
            continue

          if a == i and b == j and c == k and d == m:
            continue

          result += int(state[a][b][c][d] == '#')

proc step(state: seq[seq[seq[char]]]): seq[seq[seq[char]]] =
  for i, xss in state:
    var valss: seq[seq[char]]
    for j, xs in xss:
      var vals: seq[char]
      for k, x in xs:
        if x == '#':
          let neighbours = activeNeighbours(state, i, j, k)
          if neighbours != 2 and neighbours != 3:
            vals.add('.')
            continue
        elif x == '.':
          if activeNeighbours(state, i, j, k) == 3:
            vals.add('#')
            continue
        vals.add(x)
      valss.add(vals)
    result.add(valss)

proc hyperstep(state: seq[seq[seq[seq[char]]]]): seq[seq[seq[seq[char]]]] =
  for i, xsss in state:
    var valsss: seq[seq[seq[char]]]
    for j, xss in xsss:
      var valss: seq[seq[char]]
      for k, xs in xss:
        var vals: seq[char]
        for m, x in xs:
          if x == '#':
            let neighbours = hyperactiveNeighbours(state, i, j, k, m)
            if neighbours != 2 and neighbours != 3:
              vals.add('.')
              continue
          elif x == '.':
            if hyperactiveNeighbours(state, i, j, k, m) == 3:
              vals.add('#')
              continue
          vals.add(x)
        valss.add(vals)
      valsss.add(valss)
    result.add(valsss)

proc countActive(state: seq[seq[seq[char]]]): int =
  for xss in state:
    for xs in xss:
      for x in xs:
        result += int(x == '#')

proc hypercountActive(state: seq[seq[seq[seq[char]]]]): int =
  for xs in state:
    result += countActive(xs)

proc part1(xs: seq[string]): int =
  let cycles = 6
  var state = newSeqWith(cycles * 2 + 1, newSeqWith(cycles * 2 + xs.len, newSeqWith(cycles * 2 + xs[0].len, '.')))

  for i, x in xs:
    let full = concat(newSeqWith(cycles, '.'), toSeq(x.items), newSeqWith(cycles, '.'))
    state[cycles][cycles + i] = full

  for i in 0 ..< cycles:
    state = step(state)

  countActive(state)

proc part2(xs: seq[string]): int =
  let cycles = 6
  var state = newSeqWith(cycles * 2 + 1, newSeqWith(cycles * 2 + 1, newSeqWith(cycles * 2 + xs.len, newSeqWith(cycles * 2 + xs[0].len, '.'))))

  for i, x in xs:
    let full = concat(newSeqWith(cycles, '.'), toSeq(x.items), newSeqWith(cycles, '.'))
    state[cycles][cycles][cycles + i] = full

  for i in 0 ..< cycles:
    state = hyperstep(state)

  hypercountActive(state)

let f = strip(readFile("in17")).splitLines()
echo f.part1()
echo f.part2()
