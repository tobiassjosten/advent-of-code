-module(stdin).
-export([getline/0]).

getline() ->
    case io:get_line("") of
        eof ->
            {error, nil};

        Line ->
            {ok, Line}
    end.
