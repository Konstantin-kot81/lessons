-module(stor).

-export([init/0]).
-export([init_p/0]).
% -export([push/2]).


init() ->                          % стартует новый процесс (при помощи вызова функции stor:init_p()) и возвращате идентификатор процесса с запущеной функцией
	spawn(stor, init_p, []).
init_p() ->                        % стартует функцию loop с аккумом в виде пустого мписка
	loop([]).

loop(Acc) ->                       % функция с бесконечной рекурсией она крутится покругу
	io:format("Current state ~p~n", [Acc]),
	receive
		{push, El} ->
			loop([El | Acc]);
		{pop, Who} ->
			[H | T] = Acc,
			Who! H,
			loop(T);
		stop -> ok
	end.





% push(Stor, Val) ->	
% 	Stor ! {push, Val}.