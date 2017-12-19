# https://adventofcode.com/2017/day/18
using DataStructures

parse_instructions(data::Array) = [(parse.(split(d))...) for d in data]

mutable struct Registers
    data::DataStructures.DefaultDict{Symbol,Int64}
    id::Int64
    snd::Channel{Int64}
    rcv::Channel{Int64}
    first_sound::Int64
    sound::Int64
    sends::Int64

    Registers(input::Channel{Int64}, output::Channel{Int64}; id::Int64 = 0) = begin
        regs = DataStructures.DefaultDict{Symbol,Int64}(0)
        regs[:p] = id
        new(regs, id, output, input, 0, 0, 0)
    end
end

Base.getindex(rs::Registers, s::Symbol) = rs.data[s]
Base.getindex(rs::Registers, i::Int) = i
Base.setindex!(rs::Registers, v::Int, k::Symbol) = setindex!(rs.data, v, k)

function (rs::Registers)(op::Symbol, args...)
    if op == :add
        rs[args[1]] += rs[args[2]]
    elseif op == :mod
        rs[args[1]] = mod(rs[args[1]], rs[args[2]])
    elseif op == :mul
        rs[args[1]] *= rs[args[2]]
    elseif op == :set
        rs[args[1]] = rs[args[2]]
    end

    if op == :rcv
        # pt 1
        if rs[args[1]] > 0 && rs.sound != 0 && rs.first_sound == 0
            rs.first_sound = rs.sound
            yield()
        end

        # pt 2
        rs[args[1]] = take!(rs.rcv)
    elseif op == :snd
        rs.sound = rs[args[1]]
        put!(rs.snd, rs[args[1]])
        rs.sends += 1
    end

    if op == :jgz && rs[args[1]] > 0
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

# https://adventofcode.com/2017/day/18/input
const data = [
    "set i 31",
    "set a 1",
    "mul p 17",
    "jgz p p",
    "mul a 2",
    "add i -1",
    "jgz i -2",
    "add a -1",
    "set i 127",
    "set p 622",
    "mul p 8505",
    "mod p a",
    "mul p 129749",
    "add p 12345",
    "mod p a",
    "set b p",
    "mod b 10000",
    "snd b",
    "add i -1",
    "jgz i -9",
    "jgz a 3",
    "rcv b",
    "jgz b -1",
    "set f 0",
    "set i 126",
    "rcv a",
    "rcv b",
    "set p a",
    "mul p -1",
    "add p b",
    "jgz p 4",
    "snd a",
    "set a b",
    "jgz 1 3",
    "snd b",
    "set f 1",
    "add i -1",
    "jgz i -11",
    "snd a",
    "jgz f -16",
    "jgz a -19",
]

const instructions = data |> parse_instructions

q1 = Channel{Int64}(Inf)
q2 = Channel{Int64}(Inf)

prog0 = Registers(q1, q2, id=0)
prog1 = Registers(q2, q1, id=1)

t0 = @schedule prog0(instructions)
t1 = @schedule prog1(instructions)

yield()
while isready(q1) || isready(q2)
    yield()
end

println(prog0.first_sound)
println(prog1.sends)

close(q1)
close(q2)
