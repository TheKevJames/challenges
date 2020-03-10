-module(d02).
-export([main/0]).

readlines(File) ->
    {ok, Data} = file:read_file(File),
    Bin = binary:split(Data, [<<"\n">>, <<",">>], [global, trim]),
    [binary_to_integer(X) || X <- Bin].

nth(L, I) -> lists:nth(I+1, L).
replace(L, I, V) -> lists:sublist(L, I) ++ [V] ++ lists:nthtail(I+1, L).

exec(Xs, I) ->
    case nth(Xs, I) of
        1 ->
            Y = nth(Xs, nth(Xs, I+1)) + nth(Xs, nth(Xs, I+2)),
            exec(replace(Xs, nth(Xs, I+3), Y), I+4);
        2 ->
            Y = nth(Xs, nth(Xs, I+1)) * nth(Xs, nth(Xs, I+2)),
            exec(replace(Xs, nth(Xs, I+3), Y), I+4);
        99 ->
            nth(Xs, 0)
    end.

part1(Xs) ->
    Xs0 = replace(Xs, 1, 12),
    Xs1 = replace(Xs0, 2, 2),
    exec(Xs1, 0).

nextAttempt(Xs, Noun, Verb) ->
    case Verb of
        99 -> attempt(Xs, Noun+1, 0);
        _Else -> attempt(Xs, Noun, Verb+1)
    end.

attempt(Xs, Noun, Verb) ->
    case exec(replace(replace(Xs, 1, Noun), 2, Verb), 0) of
        19690720 -> 100 * Noun + Verb;
        _Else -> nextAttempt(Xs, Noun, Verb)
    end.

part2(Xs) -> attempt(Xs, 0, 0).

main() ->
    Xs = readlines("in02"),
    io:fwrite("~w\n~w\n", [part1(Xs), part2(Xs)]).
