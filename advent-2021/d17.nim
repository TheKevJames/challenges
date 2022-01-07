import std/options
import std/sequtils
import std/strscans
import std/strutils
import std/sugar

type Probe = object
  pos: tuple[x: int, y: int]
  vel: tuple[x: int, y: int]
  height: int

proc initProbe(vel: tuple[x: int, y: int]): Probe =
  Probe(pos: (x: 0, y: 0), height: 0, vel: vel)

proc tick(probe: Probe): Probe =
  result.pos = (x: probe.pos.x + probe.vel.x, y: probe.pos.y + probe.vel.y)
  result.vel = (x: probe.vel.x + (if probe.vel.x > 0: -1 elif probe.vel.x < 0: 1 else: 0),
                y: probe.vel.y - 1)
  result.height = max(probe.height, result.pos.y)

proc inTarget(probe: Probe, target: tuple[x: HSlice[int, int], y: HSlice[int, int]]): bool =
  probe.pos.x in target.x and probe.pos.y in target.y

proc lands(probe: Probe, target: tuple[x: HSlice[int, int], y: HSlice[int, int]]): Option[Probe] =
  var p = probe
  while p.pos.x <= target.x.b and p.pos.y >= target.y.a:
    # echo p
    if inTarget(p, target):
      return some(p)

    p = tick(p)

proc parse(s: string): tuple[x: HSlice[int, int], y: HSlice[int, int]] =
  var a, b, c, d: int
  discard scanf(s, "target area: x=$i..$i, y=$i..$i", a, b, c, d)
  (x: a .. b, y: c .. d)

proc part1(xs: seq[string]): int =
  let target = parse(xs[0])
  let valid = collect(newSeq):
    # need to get me some heuristics for great good
    for x in 1 ..< 999:
      for y in -999 ..< 999:
        let p = lands(initProbe((x: x, y: y)), target)
        if p.isSome:
          p.get()

  max(map(valid, (p) => p.height))

proc part2(xs: seq[string]): int =
  let target = parse(xs[0])
  let valid = collect(newSeq):
    # ...or maybe not. huh
    for x in 1 ..< 999:
      for y in -999 ..< 999:
        let p = lands(initProbe((x: x, y: y)), target)
        if p.isSome:
          p.get()

  len(valid)

let f = strip(readFile("in17")).splitLines()
# let f = @["target area: x=20..30, y=-10..-5"]
echo f.part1()
echo f.part2()
