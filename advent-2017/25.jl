# https://adventofcode.com/2017/day/25
mutable struct State
    state::Symbol
    tape::Array{Int64}
    idx::Int64

    State(s::Symbol) = new(s, [], 1)
end

function step!(s::State)
    if s.idx < 1
        unshift!(s.tape, 0)
        s.idx += 1
    elseif s.idx > length(s.tape)
        push!(s.tape, 0)
    end

    if s.state == :a
        if s.tape[s.idx] == 0
            s.tape[s.idx] = 1
            s.idx += 1
            s.state = :b
        else
            s.tape[s.idx] = 0
            s.idx -= 1
            s.state = :f
        end
    elseif s.state == :b
        if s.tape[s.idx] == 0
            # s.tape[idx] = 0
            s.idx += 1
            s.state = :c
        else
            s.tape[s.idx] = 0
            s.idx += 1
            s.state = :d
        end
    elseif s.state == :c
        if s.tape[s.idx] == 0
            s.tape[s.idx] = 1
            s.idx -= 1
            s.state = :d
        else
            # s.tape[s.idx] = 1
            s.idx += 1
            s.state = :e
        end
    elseif s.state == :d
        if s.tape[s.idx] == 0
            # s.tape[s.idx] = 0
            s.idx -= 1
            s.state = :e
        else
            s.tape[s.idx] = 0
            s.idx -= 1
            # s.state = :d
        end
    elseif s.state == :e
        if s.tape[s.idx] == 0
            # s.tape[s.idx] = 0
            s.idx += 1
            s.state = :a
        else
            # s.tape[s.idx] = 1
            s.idx += 1
            s.state = :c
        end
    else
        if s.tape[s.idx] == 0
            s.tape[s.idx] = 1
            s.idx -= 1
            s.state = :a
        else
            # s.tape[s.idx] = 1
            s.idx += 1
            s.state = :a
        end
    end
    s
end

iterate(s::State; iterations::Int64 = 1) = foldl((x, y) -> step!(x), s, 1:iterations)

# https://adventofcode.com/2017/day/25/input
const state = :a
const iters = 12994925

s = State(state)
iterate(s, iterations=iters)
println(s.tape |> sum)
