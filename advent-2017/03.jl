# https://adventofcode.com/2017/day/3
function get_distance(n::Integer)
    root = fld(ceil(sqrt(n)), 2)
    offset = (n - (2 * root - 1) ^ 2) % (2 * root)
    root + abs(offset - root)
end

function get_spiral_value_greater_than(target::Integer)
    max_rows = 10
    height = 2 * max_rows - 1
    matrix = fill(0, (height, height))
    matrix[max_rows, max_rows] = 1
    T = [[1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1]]

    for n in 1:((height - 2) ^ 2 - 1)
        a = convert(Int, floor(sqrt(n)))
        b = div((a + a % 2), 2)
        c = 4 * b ^ 2
        d = n - c

        if (n <= c - 2 * b)
            lindex = d + 3 * b
            rindex = b
        elseif (n <= c)
            lindex = b
            rindex = -d - b
        elseif (n <= c + 2 * b)
            lindex = b - d
            rindex = -b
        else
            lindex = -b
            rindex = d - 3 * b
        end

        lindex += max_rows
        rindex += max_rows

        value = sum(matrix[T[i][1] + lindex, T[i][2] + rindex] for i in 1:8)
        if (value > target)
            return value
        end

        matrix[lindex, rindex] = value
    end

    println("no answer found, increase m")
end

const data = 265149

println(get_distance(data))
println(get_spiral_value_greater_than(data))
