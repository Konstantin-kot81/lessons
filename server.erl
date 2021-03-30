-module(server).
-export([start/2]).
-export([stop/1]).
-export([call/2]).

-export([init/1]).

start(Name, Data) ->
    Pid = spawn(server, init, [Data]),
    register(Name, Pid), ok.

stop(Name) ->
    Name ! {stop, self()},
receive {reply, Reply} -> Reply end.

call(Name, Msg) ->
    Name ! {request, self(), Msg},
receive {reply, Reply} -> Reply end.

reply(To, Msg) ->
    To ! {reply, Msg}.

init(Data) ->
    loop(initialize(Data)).

loop(State) ->
    receive
        {request, From, Msg} ->
            {Reply, NewState} = handle_msg(Msg, State),
            reply(From, Reply),
            loop(NewState);
        {stop, From} ->
            reply(From, terminate(State))
    end.

initialize() ->
hanble_msg() ->
terminate() ->