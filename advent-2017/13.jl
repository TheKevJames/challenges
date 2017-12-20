# https://adventofcode.com/2017/day/13
function build_dict(data::Array)
    d = Dict()
    for line in data
        l = split(line, ": ")
        d[parse(Int, l[1])] = parse(Int, l[2])
    end
    d
end

function build_scanner(data::Array)
    scanner = build_dict(data)
    for k in keys(scanner)
        # k: (v, max, downwards)
        scanner[k] = [1, scanner[k], 1]
    end
    scanner
end

function tick(scanner::Dict, pos::Int64)
    pts = 0
    for key in keys(scanner)
        if pos == key && scanner[key][1] == 1
            pts = pos * scanner[pos][2]
        end

        scanner[key][1] += scanner[key][3]
        if scanner[key][1] == 1 || scanner[key][1] == scanner[key][2]
            scanner[key][3] *= -1
        end
    end
    pts
end

tick(scanner::Dict) = (p) -> tick(scanner, p)

get_severity(scanner::Dict, layers::Int64) = sum(map(tick(scanner), 0:layers))

hit(k::Int, v::Int, delay::Int64) = mod(delay + k, 2 * v - 2) == 0

avoided_hit(data::Dict, delay::Int64) = !any(hit(layer[1], layer[2], delay) for layer in data)
avoided_hit(data::Dict) = (d) -> avoided_hit(data, d)

find_delay(data::Dict) = Iterators.filter(avoided_hit(data), Iterators.countfrom(0)) |> first

# https://adventofcode.com/2017/day/13/input
const data = [
    "0: 4",
    "1: 2",
    "2: 3",
    "4: 4",
    "6: 8",
    "8: 5",
    "10: 8",
    "12: 6",
    "14: 6",
    "16: 8",
    "18: 6",
    "20: 6",
    "22: 12",
    "24: 12",
    "26: 10",
    "28: 8",
    "30: 12",
    "32: 8",
    "34: 12",
    "36: 9",
    "38: 12",
    "40: 8",
    "42: 12",
    "44: 17",
    "46: 14",
    "48: 12",
    "50: 10",
    "52: 20",
    "54: 12",
    "56: 14",
    "58: 14",
    "60: 14",
    "62: 12",
    "64: 14",
    "66: 14",
    "68: 14",
    "70: 14",
    "72: 12",
    "74: 14",
    "76: 14",
    "80: 14",
    "84: 18",
    "88: 14",
]
const layers = parse(Int, split(data[end], ": ")[1])

println(get_severity(build_scanner(data), layers))
println(find_delay(build_dict(data)))
