import parseutils
import sequtils
import sets
import strutils
import tables

# TODO: why on earth am I on nim v0.17? Upgrade, then use toHashSet!
let targetKeys = toSet(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
let targetEyes = toSet(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])

iterator passports(xs: seq[string]): seq[string] =
  var passport: seq[string] = @[]
  for line in xs:
    if line == "":
      yield passport
      passport = @[]
    passport &= split(line, ' ')
  yield passport

proc check(xs: seq[string]): bool =
  let keys = toSet(map(xs, proc(x: string): string = split(x, ':')[0]))
  keys.intersection(targetKeys) == targetKeys

proc toPair(x: string): tuple[k,v: string] =
  # TODO: splat?
  result.k = split(x, ':')[0]
  result.v = split(x, ':')[1]

proc valid(xs: seq[string]): bool =
  let d = toTable(map(xs, proc(x: string): tuple[k,v: string] = toPair(x)))
  # TODO: there's gotta be a nicer "check numeric" builtin than:
  #   all(toSeq(d["pid"].items), isDigit)
  try:
    let byr = parseInt(d["byr"])
    let eyr = parseInt(d["eyr"])
    let hgt = parseInt(d["hgt"][0 .. high(d["hgt"]) - 2])
    let iyr = parseInt(d["iyr"])

    var validHgt: bool
    if d["hgt"].endsWith("cm"):
      validHgt = (150 <= hgt and hgt <= 193)
    elif d["hgt"].endswith("in"):
      validHgt = (59 <= hgt and hgt <= 76)
    else:
      validHgt = false

    (1920 <= byr and byr <= 2002 and
     2010 <= iyr and iyr <= 2020 and
     2020 <= eyr and eyr <= 2030 and
     validHgt and
     d["hcl"].len == 7 and d["hcl"][0] == '#' and parseHexInt(d["hcl"]) > -1 and
     targetEyes.contains(d["ecl"]) and
     d["pid"].len == 9 and parseInt(d["pid"]) > -1)
  except ValueError:
    false

proc part1(xs: seq[string]): int =
  for passport in passports(xs):
    result += check(passport).int

proc part2(xs: seq[string]): int =
  for passport in passports(xs):
    if check(passport):
      result += valid(passport).int

let f = strip(readFile("in04")).splitLines()
echo f.part1()
echo f.part2()
