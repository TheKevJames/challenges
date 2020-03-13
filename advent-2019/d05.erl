-module(d05).
-export([main/0]).

readlines(File) ->
    {ok, Data} = file:read_file(File),
    Bin = binary:split(Data, [<<"\n">>, <<",">>], [global, trim]),
    [binary_to_integer(X) || X <- Bin].

nth(I, L) -> lists:nth(I+1, L).
replace(L, I, V) -> lists:sublist(L, I) ++ [V] ++ lists:nthtail(I+1, L).
param(I, X, L) ->
    case nth(I, L) div round(math:pow(10, X+1)) rem 10 of
        1 -> nth(I+X, L);
        0 -> nth(nth(I+X, L), L)
    end.

exec(L, I, Input) ->
    case nth(I, L) rem 100 of
        1 ->
            LVal = param(I, 1, L),
            RVal = param(I, 2, L),
            Val = LVal + RVal,
            exec(replace(L, nth(I+3, L), Val), I+4, Input);
        2 ->
            LVal = param(I, 1, L),
            RVal = param(I, 2, L),
            Val = LVal * RVal,
            exec(replace(L, nth(I+3, L), Val), I+4, Input);
        3 ->
            Val = Input,
            exec(replace(L, nth(I+1, L), Val), I+2, Input);
        4 ->
            Val = param(I, 1, L),
            io:fwrite("~w", [Val]),
            exec(L, I+2, Input);
        5 ->
            LVal = param(I, 1, L),
            RVal = param(I, 2, L),
            IP = if LVal /= 0 -> RVal; true -> I+3 end,
            exec(L, IP, Input);
        6 ->
            LVal = param(I, 1, L),
            RVal = param(I, 2, L),
            IP = if LVal == 0 -> RVal; true -> I+3 end,
            exec(L, IP, Input);
        7 ->
            LVal = param(I, 1, L),
            RVal = param(I, 2, L),
            Val = if LVal < RVal -> 1; true -> 0 end,
            exec(replace(L, nth(I+3, L), Val), I+4, Input);
        8 ->
            LVal = param(I, 1, L),
            RVal = param(I, 2, L),
            Val = if LVal == RVal -> 1; true -> 0 end,
            exec(replace(L, nth(I+3, L), Val), I+4, Input);
        99 ->
            nth(0, L);
        _Else -> error(io_lib:format("invalid opcode: ~w", [nth(I,L)]))
    end.

part1(L) -> exec(L, 0, 1), io:fwrite("\n").

part2(L) -> exec(L, 0, 5), io:fwrite("\n").

main() ->
    L = readlines("in05"),
    io:fwrite("~w\n~w\n", [part1(L), part2(L)]).
