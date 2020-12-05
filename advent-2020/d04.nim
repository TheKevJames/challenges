import sequtils
import sets
import strutils
import tables

let targetKeys = toHashSet(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
let targetEyes = toHashSet(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])

iterator passports(xs: seq[string]): seq[string] =
  var passport: seq[string] = @[]
  for line in xs:
    if line.len == 0:
      yield passport
      passport = @[]
      continue
    passport &= split(line, ' ')
  yield passport

proc check(xs: seq[string]): bool =
  let keys = toHashSet(map(xs, proc(x: string): string = split(x, ':')[0]))
  keys.intersection(targetKeys) == targetKeys

proc toPair(x: string): tuple[k,v: string] =
  (result.k, result.v) = split(x, ':')

proc valid(xs: seq[string]): bool =
  let d = toTable(map(xs, proc(x: string): tuple[k,v: string] = toPair(x)))
  try:
    let byr = parseInt(d["byr"])
    let eyr = parseInt(d["eyr"])
    let hgt = parseInt(d["hgt"][0 .. high(d["hgt"]) - 2])
    let iyr = parseInt(d["iyr"])

    let validHgt = (d["hgt"].endsWith("cm") and (150 <= hgt and hgt <= 193) or
                    d["hgt"].endswith("in") and (59 <= hgt and hgt <= 76))

    (1920 <= byr and byr <= 2002 and
     2010 <= iyr and iyr <= 2020 and
     2020 <= eyr and eyr <= 2030 and
     validHgt and
     d["hcl"].len == 7 and d["hcl"][0] == '#' and parseHexInt(d["hcl"]) > -1 and
     targetEyes.contains(d["ecl"]) and
     d["pid"].len == 9 and all(d["pid"], isDigit))
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
