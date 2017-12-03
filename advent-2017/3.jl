# https://adventofcode.com/2017/day/3
function get_distance(n::Integer)
    root = fld(ceil(sqrt(n)), 2)
    offset = (n - (2 * root - 1) ^ 2) % (2 * root)
    root + abs(offset - root)
end

function get_spiral_value_greater_than(target::Integer)
    m = 10
    h = 2 * m - 1
    matrix = fill(0, (h, h))
    matrix[m, m] = 1
    T = [[1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1]]

    for n in 1:((h - 2) ^ 2 - 1)
        g = floor(sqrt(n))
        r = div((g + g % 2), 2)
        q = 4 * r ^ 2
        d = n - q
        if (n <= q - 2 * r)
            j = d + 3 * r
            k = r
        else
            if (n <= q)
                j = r
                k = -d -r
            else
                if (n <= q + 2 * r)
                    j = r - d
                    k = -r
                else
                    j = -r
                    k = d - 3 * r
                end
            end
        end

        j = j + m
        k = k + m

        value = 0
        for c in 1:8
            v = [j, k]
            v += T[c]
            value += matrix[convert(Int, v[1]), convert(Int, v[2])]
        end

        matrix[convert(Int, j), convert(Int, k)] = value
        if (value > target)
            return value
        end
    end
end

data = 265149

println(get_distance(data))
println(get_spiral_value_greater_than(data))
