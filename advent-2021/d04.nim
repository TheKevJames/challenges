import sequtils
import strutils

type Board = seq[seq[int]]
type Game = tuple[order: seq[int], boards: seq[Board]]

iterator cols*[T](xs: seq[seq[T]]): seq[T] =
  for i in 0 .. xs[0].high:
    var col: seq[T]
    for x in xs:
      col.add(x[i])
    yield col

iterator flatten*[T](xss: seq[seq[T]]): T =
  for xs in xss:
    for x in xs:
      yield x

proc parse(xs: seq[string]): Game =
  result.order = map(xs[0].split(','), parseInt)

  var board: Board
  for x in xs[2 .. xs.high]:
    if x == "":
      result.boards.add(board)
      board = newSeq[seq[int]]()
      continue

    board.add(map(x.splitWhitespace(), parseInt))

proc check(board: Board, order: seq[int]): bool =
  for row in board:
    if all(row, proc (x: int): bool = x in order):
      return true

  for col in cols(board):
    if all(col, proc (x: int): bool = x in order):
      return true

  false

proc score(board: Board, order: seq[int]): int =
  let unmarked = filter(toSeq(flatten(board)), proc (x: int): bool = x notin order)
  unmarked.foldl(a + b) * order[order.high]

proc part1(xs: seq[string]): int =
  let game = parse(xs)

  for i in 0 .. len(game.order):
    for board in game.boards:
      if check(board, game.order[..i]):
        return score(board, game.order[..i])

  echo "Err"
  0

proc part2(xs: seq[string]): int =
  var game = parse(xs)

  for i in 0 .. len(game.order):
    if len(game.boards) > 1:
      game.boards = filter(game.boards, proc (b: Board): bool = not check(b, game.order[..i]))
      continue

    if check(game.boards[0], game.order[..i]):
      return score(game.boards[0], game.order[..i])

  echo "Err"
  0

let f = strip(readFile("in04")).splitLines()
echo f.part1()
echo f.part2()
