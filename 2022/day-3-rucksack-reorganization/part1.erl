#!/usr/bin/env escript
main(_) ->
    read(0).

read(N) ->
    case io:get_line("") of
        eof ->
            io:fwrite("~w~n", [N]),
            init:stop(); 
        Line ->
            {First, Second} = split(Line),
            read(N + parse(lists:uniq(First), lists:uniq(Second)))
    end.

split(Line) ->
    shift(Line, [], round((length(Line)-1)/2)).

shift(Second, First, 0) ->
    {First, Second};
shift([H | T], First, N) ->
    shift(T, First ++ [H], N-1).

parse([], _) ->
    0;
parse([H | T], List) ->
    match(H, List) + parse(T, List).

match(_, []) ->
    0;
match(C, [H | T]) when C == H ->
    value(C) + match(C, T);
match(C, [_ | T]) ->
    match(C, T).

value(C) when C == 10 ->
    0;
value(C) when C =< 90 ->
    C - 64 + 26;
value(C) ->
    C - 96.
