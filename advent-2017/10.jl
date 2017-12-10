# https://adventofcode.com/2017/day/10
function hash(data::Array, lengths::Array, pos::Int64, skipper::Int64)
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

function knot_hash(data::Array, lengths::Array, pos::Int64, skipper::Int64)
    for _ in 1:64
        pos, skipper = hash(data, lengths2, pos, skipper)
    end
    dense = [reduce(xor, data[i:i+15]) for i in 1:16:256]
    join([@sprintf("%02.x", i) for i in dense])
end

# https://adventofcode.com/2017/day/10/input
lengths = "88,88,211,106,141,1,78,254,2,111,77,255,90,0,54,205"
salt = [17, 31, 73, 47, 23]

lengths1 = [parse(Int, x) for x in split(lengths, ",")]
data = convert(Array, 0:255)
hash(data, lengths1, 1, 0)
println(data[1] * data[2])

lengths2 = vcat([Int(c) for c in lengths], salt)
println(knot_hash(convert(Array, 0:255), lengths2, 1, 0))
