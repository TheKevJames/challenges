import strutils

proc part1(xs: seq[string]): int =
  for x in xs:
    var fields = split(x, ' ')
    var rangeFields = fields[0].split('-')
    var minCount = parseInt(rangeFields[0])
    var maxCount = parseInt(rangeFields[1])
    var occurrences = count(fields[2], fields[1][0])
    if minCount <= occurrences and occurrences <= maxCount:
      result += 1

proc part2(xs: seq[string]): int =
  for x in xs:
    var fields = split(x, ' ')
    var rangeFields = fields[0].split('-')
    if (fields[2][parseInt(rangeFields[0])-1] == fields[1][0] xor
        fields[2][parseInt(rangeFields[1])-1] == fields[1][0]):
      result += 1

let f = strip(readFile("in02")).splitLines()
echo f.part1()
echo f.part2()
