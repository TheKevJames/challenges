import std/sequtils
import std/strutils
import std/sugar

iterator bin*(xs: string): char =
  for c in xs:
    for b in parseHexInt($c).toBin(4):
      yield b

type Packet = object
  version: int
  typeid: int
  value: int
  packets: seq[Packet]
  size: int

proc parse(bins: seq[char]): Packet =
  # echo "START: ", bins.join

  result.version = fromBin[int](bins[result.size ..< result.size + 3].join)
  # echo result.version
  result.size += 3

  result.typeid = fromBin[int](bins[result.size ..< result.size + 3].join)
  # echo result.typeid
  result.size += 3

  if result.typeid == 4:
    var valueBin: seq[char]
    for i in 0 .. 999:
      var digit = bins[result.size ..< result.size + 5]
      valueBin.add(digit[1 ..< 5])
      result.size += 5

      if digit[0] == '0':
        break
    result.value = fromBin[int](valueBin.join)
  else:
    if bins[result.size] == '0':
      inc result.size
      var length = fromBin[int](bins[result.size ..< result.size + 15].join)
      result.size += 15
      let target = result.size + length

      while result.size < target:
        var pkt = parse(bins[result.size .. bins.high])
        result.size += pkt.size

        # let padding = ((4 - toBin(pkt.value, 32).strip(chars = {'0'}, trailing=false).len mod 4) mod 4)
        # result.size += padding

        result.packets.add(pkt)
      # echo result.packets
    else:
      # 11 bits indicating number of sub-packets

      inc result.size
      var count = fromBin[int](bins[result.size ..< result.size + 11].join)
      result.size += 11

      for _ in 0 ..< count:
        var pkt = parse(bins[result.size .. bins.high])
        result.size += pkt.size

        # let padding = ((4 - toBin(pkt.value, 32).strip(chars = {'0'}, trailing=false).len mod 4) mod 4)
        # result.size += padding

        result.packets.add(pkt)
      # echo result.packets

    case result.typeid
    of 0:
      result.value = result.packets.foldl(a + b.value, 0)
    of 1:
      result.value = result.packets.foldl(a * b.value, 1)
    of 2:
      result.value = min(result.packets.map((p) => p.value))
    of 3:
      result.value = max(result.packets.map((p) => p.value))
    of 5:
      result.value = (if result.packets[0].value > result.packets[1].value: 1 else: 0)
    of 6:
      result.value = (if result.packets[0].value < result.packets[1].value: 1 else: 0)
    of 7:
      result.value = (if result.packets[0].value == result.packets[1].value: 1 else: 0)
    else:
      echo "Err: invalid typeid ", result.typeid

  result.size = result.size
  # echo result

proc versionsum(p: Packet): int =
  p.version + map(p.packets, versionsum).foldl(a + b, 0)

proc part1(xs: seq[string]): int =
  versionsum(parse(toSeq(bin(xs[0]))))

proc part2(xs: seq[string]): int =
  parse(toSeq(bin(xs[0]))).value

let f = strip(readFile("in16")).splitLines()
# echo "---"
# assert parse(toSeq(bin("D2FE28"))) == Packet(version: 6, typeid: 4, value: 2021, packets: @[], size: 21)
# echo "---"
# assert parse(toSeq(bin("38006F45291200"))) == Packet(version: 1, typeid: 6, value: 1, packets: @[
#   Packet(version: 6, typeid: 4, value: 10, packets: @[], size: 11),
#   Packet(version: 2, typeid: 4, value: 20, packets: @[], size: 16),
# ], size: 49)
# echo "---"
# assert parse(toSeq(bin("EE00D40C823060"))) == Packet(version: 7, typeid: 3, value: 3, packets: @[
#   Packet(version: 2, typeid: 4, value: 1, packets: @[], size: 11),
#   Packet(version: 4, typeid: 4, value: 2, packets: @[], size: 11),
#   Packet(version: 1, typeid: 4, value: 3, packets: @[], size: 11),
# ], size: 51)
# echo "==="
# echo part1(@["8A004A801A8002F478"])
# echo "---"
# echo part1(@["620080001611562C8802118E34"])
# echo "---"
# echo part1(@["C0015000016115A2E0802F182340"])
# echo "---"
# echo part1(@["A0016C880162017C3686B18A3D4780"])
# echo "+++"
echo f.part1()
echo f.part2()
