import algorithm
import math
import re
import sequtils
import strformat
import strscans
import strutils
import tables

type Direction = enum Up, Left, Down, Right  # specific order, see findRotation
type Flip = enum None, Horiz, Vert

type Tile = object
  id: int16
  data: array[10, array[10, char]]
type TileData = object
  adjacents: array[Direction, int16]  # NWSE
  rotate: int  # 0->4, clockwise
  flip: Flip
type Image = Table[int16, TileData]

# proc `$`*(t: Tile): string =
#   &"\nTile: {t.id}\n" & join(map(toSeq(0 ..< 10), proc(i: int): string = t.data[i].join), "\n") & "\n"

iterator parse(xs: seq[string]): Tile =
  var tile = Tile()
  var id: int
  var line = 0
  for x in xs:
    if scanf(x, "Tile $i:", id):
      tile.id = id.int16
      continue
    if x.len == 0:
      yield tile
      tile = Tile()
      line = 0
      continue
    for i in 0 ..< 10:
      tile.data[line][i] = x[i]
    line += 1
  yield tile

proc tileMap(tiles: seq[Tile]): Table[int16, Tile] =
  for x in tiles:
    result[x.id] = x

proc reversed(s: string): string =
  result = newString(s.len)
  for i in 0 .. s.high:
    result[s.high - i] = s[i]

proc border(x: Tile, direction: Direction): string =
  # reversing Down and Left makes the findOrientation logic simpler
  case direction
  of Up: join(x.data[0])
  of Right: join(mapIt(toSeq(0 ..< 10), x.data[it][9]))
  of Down: reversed(join(x.data[9]))
  of Left: reversed(join(mapIt(toSeq(0 ..< 10), x.data[it][0])))

proc matchingBorders(x, y: Tile): bool =
  var xOptions = @[border(x, Up), border(x, Down), border(x, Right), border(x, Left)]
  xOptions.add(map(xOptions, reversed))

  var yOptions = @[border(y, Up), border(y, Down), border(y, Right), border(y, Left)]
  yOptions.add(map(yOptions, reversed))

  for xOpt in xOptions:
    for yOpt in yOptions:
      if xOpt == yOpt:
        return true

  false

proc findMatches(xs: seq[Tile]): Table[int16, set[int16]] =
  for x in xs:
    for other in xs:
      if x.id == other.id:
        continue
      if other.id in result.getOrDefault(x.id):
        continue

      if matchingBorders(x, other):
        result.mgetOrPut(x.id, {}).incl(other.id)
        result.mgetOrPut(other.id, {}).incl(x.id)

proc part1(xs: seq[string]): int =
  result = 1
  let tiles = toSeq(parse(xs))
  for id, adjacents in tiles.findMatches.pairs:
    if adjacents.len == 2:
      result *= id

proc findRotation(x, y: Direction): int =
  floorMod(ord(x) - ord(y) + 2, 4)

proc findOrientation(x, y: Tile, direction: Direction): (int, Flip) =
  let xBorder = border(x, direction)
  let xBorderRev = reversed(xBorder)

  for dir in Direction:
    let yBorder = border(y, dir)
    if yBorder == xBorder:
      let flip = case direction
        of Up, Down: Vert
        of Left, Right: Horiz
      return (findRotation(direction, dir), flip)
    if yBorder == xBorderRev:
      return (findRotation(direction, dir), None)

  (-1, None)

proc opposite(d: Direction): Direction =
  case d
    of Up: Down
    of Left: Right
    of Down: Up
    of Right: Left

proc rotate(x: array[10, array[10, char]]): array[10, array[10, char]] =
  for i in 0 ..< 10:
    for j in 0 ..< 10:
      result[9 - j][i] = x[i][j]

proc rotate(xs: seq[string]): seq[string] =
  result = newSeq[string](xs.len)
  for x in xs:
    for i, c in x:
      result[x.high - i].add(c)

proc applyMutations(tile: var Tile, data: TileData) =
  for i in 0 ..< data.rotate:
    tile.data = rotate(tile.data)

  case data.flip
    of Horiz:
      let tmp = tile.data
      for i in 0 ..< 10:
        tile.data[i] = tmp[9 - i]
    of Vert:
      for i, row in tile.data:
        let tmp = tile.data[i]
        for j in 0 ..< 10:
          tile.data[i][j] = tmp[9 - j]
    of None: discard

proc layoutTile(image: var Image, tiles: var Table[int16, Tile],
                matches: Table[int16, set[int16]], id: int16) =
  for direction in Direction:
    if image[id].adjacents[direction] != 0:
      continue

    image[id].adjacents[direction] = -1.int16
    for other in matches[id]:
      let (rotate, flip) = findOrientation(tiles[id], tiles[other], direction)
      if rotate == -1:
        continue

      # mark neighbours
      image[id].adjacents[direction] = other
      image[other].adjacents[opposite(direction)] = id

      # flip the new tile into place
      image[other].rotate = rotate
      image[other].flip = flip
      tiles[other].applyMutations(image[other])

      image.layoutTile(tiles, matches, other)
      break

proc layoutImage(tiles: var Table[int16, Tile], matches: Table[int16, set[int16]], id: int16): Image =
  for x in tiles.keys:
    result[x] = TileData()

  result.layoutTile(tiles, matches, id)

proc render(image: Image, tiles: Table[int16, Tile], id: int16): seq[string] =
  var leftmost = id
  while leftmost != -1:
    var row = newSeqWith(8, "")

    var next = leftmost
    while next != -1:
      for i in 0 ..< 8:
        # strip borders as we go
        row[i].add(join(tiles[next].data[i + 1][1 .. 8]))
      next = image[next].adjacents[Right]

    result.add(row)
    leftmost = image[leftmost].adjacents[Down]

proc matches(row: string, pattern: Regex): set[int16] =
  var start = 0
  while (let pos = row.find(pattern, start); pos >= 0):
    result.incl(pos.int16)
    start = pos + 1

proc countMatches(sea: seq[string], patterns: seq[Regex]): int =
  for i in 0 .. sea.len - 3:
    var ms = sea[i].matches(patterns[0])
    if ms.card == 0:
      continue

    ms = ms * sea[i + 1].matches(patterns[1])
    if ms.card == 0:
      continue

    ms = ms * sea[i + 2].matches(patterns[2])
    if ms.card == 0:
      continue

    result += ms.card

proc countMonsters(sea: seq[string]): int =
  let monster = @[
    "                  # ",
    "#    ##    ##    ###",
    " #  #  #  #  #  #   ",
  ]
  let patterns = mapIt(monster, re(it.replace(' ', '.')))

  var viewport = sea

  for _ in 0 ..< 4:
    let count = countMatches(viewport, patterns)
    if count != 0:
      return count
    viewport = rotate(viewport)

  viewport = map(viewport, reversed)
  for _ in 0 ..< 4:
    let count = countMatches(viewport, patterns)
    if count != 0:
      return count
    viewport = rotate(viewport)

proc part2(xs: seq[string]): int =
  let tiles = toSeq(parse(xs))
  let matches = tiles.findMatches
  # arbitrarily start with random corner piece
  let topleft = toSeq(filter(
    toSeq(matches.pairs),
    proc(t: tuple[id: int16, adjacents: set[int16]]): bool = t.adjacents.len == 2))[0][0]

  var tilemap = tiles.tileMap
  # actually build the damn thingj
  let image = layoutImage(tilemap, tiles.findMatches, topleft)

  # find the monsters
  let sea = render(image, tilemap, topleft)
  let monsters = countMonsters(sea)
  foldl(sea, a + count(b, '#'), 0) - monsters * 15

let f = strip(readFile("in20")).splitLines()
echo f.part1()
echo f.part2()
