-module(test).


-export([p_01/1]).

p_01(List) -> p_01(List, {[]});
p_01([H, H | T], Acc)->
	p_01 (T, [H |Acc]);
p_01([H | T], Acc) ->
	p_01(T ,[H | {Acc}]);
	p_01({[]}, {Acc}).