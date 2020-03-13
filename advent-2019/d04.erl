-module(d04).
-export([main/0]).

readlines(File) ->
    {ok, Data} = file:read_file(File),
    Bins = binary:split(Data, [<<"\n">>, <<"-">>], [global, trim_all]),
    [binary_to_integer(L) || L <- Bins].

values_in_range(L) -> lists:seq(lists:nth(1,L) + 1, lists:nth(2,L)-1).

has_double(Int) ->
    V = lists:foldl(fun(X, Acc) -> case Acc of 1 -> 1; X -> 1; _Else -> X end end, 0, integer_to_list(Int)),
    V == 1.

has_double_strict(Int) ->
    Vs = lists:foldl(fun(X, Acc) -> dict:update_counter(X, 1, Acc) end, dict:new(), integer_to_list(Int)),
    Twos = dict:filter(fun(_, V) -> V == 2 end, Vs),
    not dict:is_empty(Twos).

increases(Int) ->
    V = lists:foldl(fun(X, Acc) -> if X>=Acc -> X; true -> 999 end end, 0, integer_to_list(Int)),
    V /= 999.

part1(L) ->
    Foo = [X || X <- values_in_range(L), increases(X), has_double(X)],
    length(Foo).

part2(L) ->
    Foo = [X || X <- values_in_range(L), increases(X), has_double_strict(X)],
    length(Foo).

main() ->
    L = readlines("in04"),
    io:fwrite("~w\n~w\n", [part1(L), part2(L)]).
