-module(d07).
-export([main/0]).

readlines(File) ->
    {ok, Data} = file:read_file(File),
    Bin = binary:split(Data, [<<"\n">>, <<",">>], [global, trim]),
    [binary_to_integer(X) || X <- Bin].

nth(I, L) -> lists:nth(I+1, L).
replace(L, I, V) -> lists:sublist(L, I) ++ [V] ++ lists:nthtail(I+1, L).

perms([]) -> [[]];
perms(L) -> [[H|T] || H <- L, T <- perms(L--[H])].

param(I, X, L) ->
    case nth(I, L) div round(math:pow(10, X+1)) rem 10 of
        1 -> nth(I+X, L);
        0 -> nth(nth(I+X, L), L)
    end.

exec(L, Inputs) -> exec(L, 0, Inputs, []).
exec(L, I, Inputs, Output) ->
    case nth(I, L) rem 100 of
        1 ->
            LVal = param(I, 1, L),
            RVal = param(I, 2, L),
            Val = LVal + RVal,
            exec(replace(L, nth(I+3, L), Val), I+4, Inputs, Output);
        2 ->
            LVal = param(I, 1, L),
            RVal = param(I, 2, L),
            Val = LVal * RVal,
            exec(replace(L, nth(I+3, L), Val), I+4, Inputs, Output);
        3 ->
            Val = lists:nth(1, Inputs),
            exec(replace(L, nth(I+1, L), Val), I+2, lists:nthtail(1, Inputs), Output);
        4 ->
            Val = param(I, 1, L),
            exec(L, I+2, Inputs, Output ++ [Val]);
        5 ->
            LVal = param(I, 1, L),
            RVal = param(I, 2, L),
            IP = if LVal /= 0 -> RVal; true -> I+3 end,
            exec(L, IP, Inputs, Output);
        6 ->
            LVal = param(I, 1, L),
            RVal = param(I, 2, L),
            IP = if LVal == 0 -> RVal; true -> I+3 end,
            exec(L, IP, Inputs, Output);
        7 ->
            LVal = param(I, 1, L),
            RVal = param(I, 2, L),
            Val = if LVal < RVal -> 1; true -> 0 end,
            exec(replace(L, nth(I+3, L), Val), I+4, Inputs, Output);
        8 ->
            LVal = param(I, 1, L),
            RVal = param(I, 2, L),
            Val = if LVal == RVal -> 1; true -> 0 end,
            exec(replace(L, nth(I+3, L), Val), I+4, Inputs, Output);
        99 -> Output;
        _Else -> error(io_lib:format("invalid opcode: ~w", [nth(I,L)]))
    end.

execChain(L, Inputs) -> execChain(L, Inputs, 0).
execChain(L, Inputs, Start) -> lists:foldl(fun(Input, Acc) -> exec(L, [Input] ++ Acc) end, [Start], Inputs).

execLoop(L, Inputs) -> execLoop(L, Inputs, 0).
execLoop(L, Inputs, Start) ->
    [Val] = execChain(L, Inputs, Start),
    execLoop(L, Inputs, Val).

part1(L) -> lists:max(lists:flatten([execChain(L, Ins) || Ins <- perms(lists:seq(0, 4))])).
% TODO: part2 requires the `exec` loops receive Inputs of arbitrary lengths and do not shut down between iterations
% ...rewrite to use messaging passing?
part2(L) -> [execLoop(L, Ins) || Ins <- perms(lists:seq(5, 9))].

main() ->
    L = readlines("in07"),
    io:fwrite("~w\n~w\n", [part1(L), part2(L)]).
