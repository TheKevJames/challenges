# https://adventofcode.com/2017/day/15
function gen1(always::Bool)
    # https://adventofcode.com/2017/day/15/input
    v = 722
    if always
        return Channel() do c
            while true
                v = (v * 16807) % 2147483647
                push!(c, v)
            end
        end
    end

    Channel() do c
        while true
            v = (v * 16807) % 2147483647
            if mod(v, 4) == 0
                push!(c, v)
            end
        end
    end
end

function gen2(always::Bool)
    # https://adventofcode.com/2017/day/15/input
    v = 354
    if always
        return Channel() do c
            while true
                v = (v * 48271) % 2147483647
                push!(c, v)
            end
        end
    end

    Channel() do c
        while true
            v = (v * 48271) % 2147483647
            if mod(v, 8) == 0
                push!(c, v)
            end
        end
    end
end

function judge(always::Bool, upto::Int64)
    total = 0
    for (i, (g1, g2)) in enumerate(zip(gen1(always), gen2(always)))
        if (g1 & 0xffff) == (g2 & 0xffff)
            total += 1
        end

        if i == upto
            return total
        end
    end
end

println(judge(true, 40000000))
println(judge(false, 5000000))
