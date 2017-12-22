# https://adventofcode.com/2017/day/22
mutable struct Virus
    x::Int64
    y::Int64
    heading::Int64
    infections::Int64

    Virus(pos::Int64) = begin
        new(pos, pos, 0, 0)
    end
end

function move(v::Virus)
    d = v.heading % 4
    if d % 2 == 0
        v.x += (d - 1)
    else
        v.y += (2 - d)
    end
end

function expand!(grid::Array, v::Virus)
    l = length(grid)
    g = ["." ^ (l + 2)]
    for i in 1:l
        push!(g, "." * grid[i] * ".")
    end
    push!(g, "." ^ (l + 2))

    v.x += 1
    v.y += 1
    g
end

function tick!(grid::Array, v::Virus)
    if grid[v.x][v.y] == '#'
        v.heading += 1
    else
        v.heading += 3
    end

    t = collect(grid[v.x])
    if grid[v.x][v.y] == '#'
        t[v.y] = '.'
    else
        t[v.y] = '#'
        v.infections += 1
    end
    grid[v.x] = join(t)

    move(v)
    l = length(grid)
    if v.x == 0 || v.x > l || v.y == 0 || v.y > l
        return expand!(grid, v)
    end

    grid
end

function tickv2!(grid::Array, v::Virus)
    if grid[v.x][v.y] == '.'
        v.heading += 3
    elseif grid[v.x][v.y] == '#'
        v.heading += 1
    elseif grid[v.x][v.y] == 'F'
        v.heading += 2
    end

    t = collect(grid[v.x])
    if grid[v.x][v.y] == '.'
        t[v.y] = 'W'
    elseif grid[v.x][v.y] == 'W'
        t[v.y] = '#'
        v.infections += 1
    elseif grid[v.x][v.y] == '#'
        t[v.y] = 'F'
    elseif grid[v.x][v.y] == 'F'
        t[v.y] = '.'
    end
    grid[v.x] = join(t)

    move(v)
    l = length(grid)
    if v.x == 0 || v.x > l || v.y == 0 || v.y > l
        return expand!(grid, v)
    end

    grid
end

function ticks!(grid::Array, v::Virus; iterations::Int64 = 1)
    for i in 1:iterations
        grid = tick!(grid, v)
    end
    grid
end

function ticksv2!(grid::Array, v::Virus; iterations::Int64 = 1)
    for i in 1:iterations
        grid = tickv2!(grid, v)
    end
    grid
end

# https://adventofcode.com/2017/day/22/input
const data = [
    "##.###.....##..#.####....",
    "##...#.#.#..##.#....#.#..",
    "...#..#.###.#.###.##.####",
    "..##..###....#.##.#..##.#",
    "###....#####..###.#..#..#",
    ".....#.#...#..##..#.##...",
    ".##.#.###.#.#...##.#.##.#",
    "......######.###......###",
    "#.....##.#....#...#......",
    "....#..###.#.#.####.##.#.",
    ".#.#.##...###.######.####",
    "####......#...#...#..#.#.",
    "###.##.##..##....#..##.#.",
    "..#.###.##..#...#######..",
    "...####.#...###..#..###.#",
    "..#.#.......#.####.#.....",
    "..##..####.######..##.###",
    "..#..#..##...#.####....#.",
    ".#..#.####.#..##..#..##..",
    "......#####...#.##.#....#",
    "###..#...#.#...#.#..#.#.#",
    ".#.###.#....##..######.##",
    "##.######.....##.#.#.#..#",
    "..#..##.##..#.#..###.##..",
    "#.##.##..##.#.###.......#",
]

d = copy(data)
v = Virus(cld(length(d), 2))

ticks!(d, v, iterations=10_000)
println(v.infections)

d = copy(data)
v = Virus(cld(length(d), 2))

ticksv2!(d, v, iterations=10_000_000)
println(v.infections)
