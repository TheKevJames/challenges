# https://adventofcode.com/2017/day/17
function spinlock(skipper::Int64; value::Int64 = 2017)
    data = [0, 0]
    pos = 1
    for i in 1:value
        pos = ((pos - 1 + skipper) % i) + 2
        if value == 2017 || pos == 2
            insert!(data, pos, i)
        end
    end
    data, pos
end

# https://adventofcode.com/2017/day/17/input
const skipper = 359

data, pos = spinlock(skipper)
println(data[pos+1])
data, _ = spinlock(skipper, value=50000000)
println(data[2])
