import algorithm
import intsets
import sequtils
import strscans
import strutils

proc main(xs: seq[string]): (int, IntSet) =
  var fabric = newSeqWith(1000, newSeq[int](1000))

  for x in xs:
    var id, left, top, width, height: int
    discard scanf(x, "#$i @ $i,$i: $ix$i", id, left, top, width, height)

    var intact = true
    for i in 0..width-1:
      for j in 0..height-1:
        if fabric[left+i][top+j] == 1:
          result[0] += 1
        fabric[left+i][top+j] += 1
        if fabric[left+i][top+j] > 1:
          intact = false

    if intact:
      result[1].incl(id)

let f = strip(readFile("in03")).splitLines()
let (part1, part2) = f.main()
echo part1

let (_, part2r) = reversed(f).main()
echo part2 * part2r
