-module(calc).

-export([init/0]).


init() ->
	loop(0).

loop(Acc) ->
	receive
		{add, X} ->
			loop(X + Acc);
		{mul, X} ->
			loop(X * Acc);
		{div1, X} ->
			loop(X / Acc);
		{sub, X} ->
			loop(X - Acc);
		print -> 
		    io:format("Curent value ~p~n", [Acc]),
		    loop(Acc)
	
	end.