# https://adventofcode.com/2017/day/6
function reallocate_once(data::Array)
    m = maximum(data)
    idx = find(x -> x == m, data)[1]

    value = 0
    for (n, i) in enumerate(Iterators.cycle(1:length(data)))
        if n < idx
            continue
        end

        if n == idx
            value = data[i]
            data[i] = 0
            continue
        end

        data[i] += 1
        value -= 1
        if value == 0
            return data
        end
    end
end

function reallocate(data::Array)
    states = Set()
    for i in Iterators.countfrom(1)
        push!(states, data)
        data = reallocate_once(copy(data))
        if data in states
            return i, data
        end
    end
end

# https://adventofcode.com/2017/day/6/input
const data = [0, 5, 10, 0, 11, 14, 13, 4, 11, 8, 8, 7, 1, 4, 12, 11]

idx, state = reallocate(copy(data))
println(idx)

_, state = reallocate(copy(data))
idx, _ = reallocate(copy(state))
println(idx)
