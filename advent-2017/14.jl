# https://adventofcode.com/2017/day/14
function hash(data::Array, lengths::Array; pos::Int64 = 1, skipper::Int64 = 0)
    for l in lengths
        if pos + l <= length(data)
            idx = pos + l - 1
            data[pos:idx] = reverse(data[pos:idx])
        else
            chunk = length(data) - pos + 1
            extra = l - chunk
            grab = reverse(vcat(data[pos:end], data[1:extra]))
            data[pos:end] = grab[1:chunk]
            data[1:extra] = grab[chunk + 1:end]
        end
        pos += l + skipper
        while pos > length(data)
            pos -= length(data)
        end
        skipper += 1
    end
    pos, skipper
end

function knot_hash(data::Array, lengths::Array; pos::Int64 = 1, skipper::Int64 = 0)
    for _ in 1:64
        pos, skipper = hash(data, lengths, pos=pos, skipper=skipper)
    end
    dense = [reduce(xor, data[i:i+15]) for i in 1:16:256]
    join([@sprintf("%02.x", i) for i in dense])
end

function to_binary(data::String)
    join([bin(parse(Int, string(c), 16), 4) for c in data])
end

function knot_grid(data::String)
    grid = String[]
    for i in 0:127
        d = vcat([Int(c) for c in data], Int('-'), [Int(c) for c in string(i)],
                 [17, 31, 73, 47, 23])
        knot = knot_hash(convert(Array, 0:255), d)
        push!(grid, string(to_binary(knot)))
    end
    grid
end

function region(grid::Array, i::Int64, j::Int64)
    if i < 1 || i > 128 || j < 1 || j > 128
        return 0
    end
    if grid[i][j] == '0'
        return 0
    end

    # Because `grid[i][j] = '0'` would be too simple...
    x = collect(grid[i])
    x[j] = '0'
    grid[i] = join(x)

    region(grid, i - 1, j)
    region(grid, i + 1, j)
    region(grid, i, j - 1)
    region(grid, i, j + 1)
    1
end

# https://adventofcode.com/2017/day/14/input
const data = "amgozmfv"

grid = knot_grid(data)
println(sum([parse(Int, d) for line in grid for d in line]))
println(sum([region(grid, i, j) for i in 1:128 for j in 1:128]))
