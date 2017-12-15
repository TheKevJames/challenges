# https://adventofcode.com/2017/day/15
# https://adventofcode.com/2017/day/15/input
function gen1(; v::Int64 = 722, always::Bool = true)
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

# https://adventofcode.com/2017/day/15/input
function gen2(; v::Int64 = 354, always::Bool = true)
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

function judge(upto::Int64; always::Bool = true)
    total = 0
    for (i, (g1, g2)) in enumerate(zip(gen1(always=always), gen2(always=always)))
        if (g1 & 0xffff) == (g2 & 0xffff)
            total += 1
        end

        if i == upto
            return total
        end
    end
end

println(judge(40000000))
println(judge(5000000, always=false))
