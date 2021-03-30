-module(my_timer).

-export([send_after/2]).
-export([sleep/1]).
-export([send/3]).


send_after(Time, Msg) ->
    spawn(my_timer, send, [self(), Time, Msg]).

send(Pid, Time, Msg) ->
    receive
    after
        Time ->
            Pid ! Msg
    end.
sleep(T) ->
    receive
    after
    T -> true
    end.