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

function get_severity(scanner::Dict, layers::Int64)
    # TODO: reduce?
    pts = 0
    for pos in 0:layers
        pts += tick(scanner, pos)
    end
    pts
end

function check_hit(data::Dict, delay::Int64)
    # TODO: any?
    for layer in data
        if mod(delay + layer[1], 2 * layer[2] - 2) == 0
            return false
        end
    end
    true
end

function find_delay(data::Dict)
    # TODO: first?
    for delay in Iterators.countfrom(0)
        if check_hit(data, delay)
            return delay
        end
    end
end

# https://adventofcode.com/2017/day/13/input
data = [
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
layers = parse(Int, split(data[end], ": ")[1])

println(get_severity(build_scanner(data), layers))
println(find_delay(build_dict(data)))
