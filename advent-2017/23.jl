# https://adventofcode.com/2017/day/23
using DataStructures

parse_instructions(data::Array) = [(parse.(split(d))...) for d in data]

mutable struct Registers
    data::DataStructures.DefaultDict{Symbol,Int64}
    muls::Int64

    Registers(; a::Int64 = 0) = begin
        regs = DataStructures.DefaultDict{Symbol,Int64}(0)
        regs[:a] = a
        new(regs, 0)
    end
end

Base.getindex(rs::Registers, s::Symbol) = rs.data[s]
Base.getindex(rs::Registers, i::Int) = i
Base.setindex!(rs::Registers, v::Int, k::Symbol) = setindex!(rs.data, v, k)

function (rs::Registers)(op::Symbol, args...)
    if op == :mul
        rs[args[1]] *= rs[args[2]]
        rs.muls += 1
    elseif op == :set
        rs[args[1]] = rs[args[2]]
    elseif op == :sub
        rs[args[1]] -= rs[args[2]]
    end

    if op == :jnz && rs[args[1]] != 0
        return rs[args[2]]
    else
        return 1
    end
end

function (rs::Registers)(instructions::Array)
    idx = 1
    while idx <= length(instructions)
        idx += rs(instructions[idx]...)
    end
end

# https://adventofcode.com/2017/day/23/input
const data = [
    "set b 57",
    "set c b",
    "jnz a 2",
    "jnz 1 5",
    "mul b 100",
    "sub b -100000",
    "set c b",
    "sub c -17000",
    "set f 1",
    "set d 2",
    "set e 2",
    "set g d",
    "mul g e",
    "sub g b",
    "jnz g 2",
    "set f 0",
    "sub e -1",
    "set g e",
    "sub g b",
    "jnz g -8",
    "sub d -1",
    "set g d",
    "sub g b",
    "jnz g -13",
    "jnz f 2",
    "sub h -1",
    "set g b",
    "sub g c",
    "jnz g 2",
    "jnz 1 3",
    "sub b -17",
    "jnz 1 -23",
]

const instructions = data |> parse_instructions

r = Registers()
r(instructions)
println(r.muls)

function prog()
    a = 1
    b = 105700
    c = b + 17000
    d = 0
    e = 0
    f = 0
    g = 0
    h = 0

    while true
        d = 2
        e = 2
        f = 1
        while d * d <= b
            if b % d == 0
                f = 0
                break
            end
            d += 1
        end

        if f == 0
            h += 1
        end
        g = b - c
        b += 17

        g == 0 && break
    end

    h
end

p = prog()
println(p)
