import strutils

# TODO: nim has no builtin rem operation?
proc rem(n, m: int): int = ((n mod m) + m) mod m

proc parseRow(x: string): (char, int) =
  (x[0], parseInt(x[1 .. high(x)]))

proc part1(xs: seq[string]): int =
  var face = 1  # N, E, S, W
  var x, y = 0
  for inst in xs:
    let (cmd, val) = parseRow(inst)
    if cmd == 'N' or (cmd == 'F' and face == 0):
      y += val
    elif cmd == 'E' or (cmd == 'F' and face == 1):
      x += val
    elif cmd == 'S' or (cmd == 'F' and face == 2):
      y -= val
    elif cmd == 'W' or (cmd == 'F' and face == 3):
      x -= val
    elif cmd == 'L':
      face = rem(face - val div 90, 4)
    elif cmd == 'R':
      face = rem(face + val div 90, 4)

  abs(x) + abs(y)

proc part2(xs: seq[string]): int =
  var x, y = 0
  var wx = 10
  var wy = 1
  for inst in xs:
    let (cmd, val) = parseRow(inst)
    if cmd == 'N':
      wy += val
    elif cmd == 'E':
      wx += val
    elif cmd == 'S':
      wy -= val
    elif cmd == 'W':
      wx -= val
    elif cmd == 'F':
      x += val * wx
      y += val * wy
    else:
      if val == 180:
        wx = -wx
        wy = -wy
      elif (cmd == 'L' and val == 90) or (cmd == 'R' and val == 270):
        let tmp = wx
        wx = -wy
        wy = tmp
      elif (cmd == 'L' and val == 270) or (cmd == 'R' and val == 90):
        let tmp = wx
        wx = wy
        wy = -tmp

  abs(x) + abs(y)


let f = strip(readFile("in12")).splitLines()
echo f.part1()
echo f.part2()
