# TODO: is this seriously not solveable without external libraries???
import bigints
import math
import sequtils
import strutils

proc part1(xs: seq[string]): int =
  let now = parseInt(xs[0])
  let busses = map(filter(xs[1].split(","),
                          proc(x: string): bool = x != "x"),
                   parseInt)

  let arrivals = map(busses, proc(x: int): int = int(ceil(now / x)) * x)
  let next = minIndex(arrivals)
  (busses[next] * (arrivals[next] - now))

proc bezout(x: BigInt, y: BigInt): (BigInt, BigInt) =
  # via ext euclid
  var sp, t = initBigInt(0)
  var s, tp = initBigInt(1)
  var r = x
  var rp = y

  while rp != 0:
    let q = r div rp
    (r, rp) = (rp, r - q * rp)
    (s, sp) = (sp, s - q * sp)
    (t, tp) = (tp, t - q * tp)

  (s, t)

proc reduce(xs: seq[tuple[n: BigInt, a: BigInt]]): seq[tuple[n: BigInt, a: BigInt]] =
  # stepwise crt
  let (m0, m1) = bezout(xs[0].n, xs[1].n)
  let n3 = xs[0].n * xs[1].n
  var a3 = (xs[0].a * m1 * xs[1].n + xs[1].a * m0 * xs[0].n) mod n3
  concat(xs[2 .. high(xs)], @[(n3, a3)])

proc part2(xs: seq[string]): BigInt =
  let busses = map(filter(toSeq(pairs(xs[1].split(","))),
                          proc(x: tuple[key: int, val: string]): bool = x.val != "x"),
                   proc(x: tuple[key: int, val: string]): tuple[off: int, id: int] =
                     (x.key, parseInt(x.val)))

  # precompute "a" values, rename for crt
  var system = map(busses, proc(x: tuple[off: int, id: int]): tuple[n: BigInt, a: BigInt] =
                             (initBigInt(x.id), initBigInt((x.id - x.off mod x.id) mod x.id)))
  while len(system) > 1:
    system = reduce(system)

  system[0].a

let f = strip(readFile("in13")).splitLines()
echo f.part1()
echo f.part2()
