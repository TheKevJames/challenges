-module(d01).
-export([main/0]).

readlines(File) ->
    {ok, Data} = file:read_file(File),
    Bin = binary:split(Data, [<<"\n">>], [global, trim]),
    [binary_to_integer(X) || X <- Bin].

compute(X) -> floor(X / 3) - 2.

part1(Xs) ->
    lists:sum([compute(X) || X <- Xs]).

computeAll(X) ->
    case compute(X) of
        Y when Y > 0 ->
            Y + computeAll(Y);
        _Else ->
            0
    end.

part2(Xs) ->
    lists:sum([computeAll(X) || X <- Xs]).

main() ->
    Xs = readlines("in01"),
    io:fwrite("~w\n~w\n", [part1(Xs), part2(Xs)]).
