#!/usr/bin/env escript
main(_) ->
    read(0).

read(N) ->
    case io:get_line("") of
        eof ->
            io:fwrite("~w~n", [N]),
            init:stop(); 
        Line ->
            read(N + badge(lists:uniq(Line)))
    end.

badge(List) ->
    match(List, false).

match(List, Nested) ->
    Next = lists:uniq(io:get_line("")),
    [H | T] = [X || X <- List, Y <- Next, X =:= Y],
    if
        Nested -> value(H);
        true -> match([H] ++ T, true)
    end.

value(C) when C == 10 ->
    0;
value(C) when C =< 90 ->
    C - 64 + 26;
value(C) ->
    C - 96.
