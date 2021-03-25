-module(texts).

-export([count_words/1]).
-export([split/2]).

%% "Hello my dear friend. Hello how are you. Hello how is your bussiness." -> 
%% [{"Hello", 3},{"how", 2}, ...]

count_words(List) ->
	io:format("~p => List ~p~n", [?LINE, List]),
    ok.
    % Div = 32,
    % L = anles:split(List, Div),
    % io:format("~p => L ~p~n", [?LINE, L]).
split(List, [32, $.]) ->
    io:format("~p => List ~p~n", [?LINE, List, [32, $.]]),
    ok.