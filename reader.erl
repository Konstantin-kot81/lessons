%%%%%%% 18.02.2021 %%%%%%%%%%%%%%%%%%%% LESSON_7 %%%%%%%%%%%%%%%%%%%%

% программа которая принемает имя файлпа и выводит егосодержимое на экра

-module(reader).

-export([read/1]).
-export([write/2]).
-export([read_cons/1]).



% reader:read("stor.erl").

read(FileName) ->
	case file:open(FileName, [read, binary]) of
		{ok, IoDevice} ->
			read_content(IoDevice, 1);
		_error ->
			io:format("ERROR!!! ~p~n", [_error])
	end.

read_content(IoDevice, X) ->
	case file:read_line(IoDevice) of
		eof -> ok;
		{ok, Data} ->
			io:format("~w) ~ts", [X, Data]),
			read_content(IoDevice, X + 1);
		_error ->
			io:format("ERROR! ~p~n", [_error])
	end.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% reader:write("sch.txt", "I had a cat two ears ago").

write(FileName, Content) ->
	case file:open(FileName, [write, append]) of
		{ok, IoDevice} ->
			write_content(IoDevice, Content),
			file:close(IoDevice);
		_error ->
			io:format("ERROR!!! ~p~n", [_error])
	end.

write_content(IoDevice, Content) ->
	file:write(IoDevice, erlang:iolist_to_binary([Content, "\n"])).   % "\n" or 10


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



read_cons(FileName) ->
	case file:open(FileName, [read]) of
		{ok, IoDevice} ->
			read_cons_2(IoDevice),
		 	file:close(IoDevice);
		 _error ->
		 	io:format("ERROR!!! ~p~n", [_error])
	end.

read_cons_2(IoDevice) ->
	case file:read_line(IoDevice) of
		eof -> ok;
		{ok, Data} ->
			io:format("~s", [Data]),
			read_cons_2(IoDevice);
		_error ->
			io:format("ERROR! ~p~n", [_error])
	end.
	