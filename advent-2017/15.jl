# https://adventofcode.com/2017/day/15
struct Generator
    seed::Int64
    mult::Int64
    divisor::Int64
end

Base.start(g::Generator) = g.seed
Base.next(g::Generator, state::Int64) = (state = (state * g.mult) % g.divisor; (state, state))
Base.done(g::Generator, state::Int64) = false

equal(lhs::Int64, rhs::Int64) = lhs & 0xffff == rhs & 0xffff
mult_4(x) = xor(x, 0x3) & 0x3 == 0x3
mult_8(x) = xor(x, 0x7) & 0x7 == 0x7

function judge(seeds::Array, upto::Int64; always::Bool = true)
    if always
        lhs = Generator(seeds[1], 16807, 2147483647)
        rhs = Generator(seeds[2], 48271, 2147483647)
    else
        lhs = Iterators.filter(mult_4, Generator(seeds[1], 16807, 2147483647))
        rhs = Iterators.filter(mult_8, Generator(seeds[2], 48271, 2147483647))
    end

    reduce(+, 0, equal(l, r) for (l, r) in Iterators.take(zip(lhs, rhs), upto))
end

# https://adventofcode.com/2017/day/15/input
const data = [722, 354]

println(judge(data, 40000000))
println(judge(data, 5000000, always=false))
