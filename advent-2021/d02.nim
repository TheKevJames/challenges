import strutils

proc part1(xs: seq[string]): int =
  var depth, pos: int
  for x in xs:
    var cmd = x.splitWhitespace()
    case cmd[0]
    of "forward":
      pos += cmd[1].parseInt()
    of "down":
      depth += cmd[1].parseInt()
    of "up":
      depth -= cmd[1].parseInt()
    else:
      echo "Err: ", x
  depth * pos

proc part2(xs: seq[string]): int =
  var aim, depth, pos: int
  for x in xs:
    var cmd = x.splitWhitespace()
    case cmd[0]
    of "forward":
      depth += aim * cmd[1].parseInt()
      pos += cmd[1].parseInt()
    of "down":
      aim += cmd[1].parseInt()
    of "up":
      aim -= cmd[1].parseInt()
    else:
      echo "Err: ", x
  depth * pos

let f = strip(readFile("in02")).splitLines()
echo f.part1()
echo f.part2()
