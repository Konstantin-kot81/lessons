%%%-------------------------------------------------------------------
%%% @author kot
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. Oct 2021 22:03
%%%-------------------------------------------------------------------
-module(identificator).
-author("kot").

%% API
-export([gen_new/3]).

-export([gen_new_n/4]).

-export([parse_seq/1]).

gen_new(Const, Id, Lit) ->
  NewId = gen_id(Id),
  NewLit = gen_lit(Lit),
  Concatenated = concat(Const, NewId, NewLit),
  {Concatenated, {Const, NewId, NewLit}}.
%%------------------------------------------------------------------------------
gen_id([$9, $9, $9, $9, $9, $9]) -> {error,finish};

gen_id(Id) ->
  RevId = lists:reverse(Id),
  NewRevId = gen_id2(RevId),
  lists:reverse(NewRevId).

gen_id2([$9 | Rest]) ->
  [$9 | gen_id2(Rest)];

gen_id2([H | Rest]) ->
  [H + 1 | Rest];

gen_id2([]) -> [].
%%---------------------------------------------------
gen_lit([$Z]) -> [$A];

gen_lit([Lit]) -> [Lit + 1].
%%---------------------------------------------------
concat(Const, NewId, NewLit) ->
  Const ++ "." ++ NewId ++ "." ++ NewLit.
%%------------------------------------------------------------------------------
gen_new_n(Const, NewId, NewLit, N) ->
  gen_new_n(Const, NewId, NewLit, N, []).

gen_new_n(Const, NewId, NewLit, 0, Acc) ->
  {lists:reverse(Acc), {Const, NewId, NewLit}};

gen_new_n(Const, Id, Lit, N, Acc) ->
  {Concatenated, {NewConst, NewId, NewLit}} = gen_new(Const, Id, Lit),
  gen_new_n(NewConst, NewId, NewLit, N - 1, [Concatenated | Acc]).
%%------------------------------------------------------------------------------
parse_seq(Encod) ->
  {Const, Rest1} = parse_first_token(Encod),
  {NewId, NewLit} = parse_rest(Rest1),
  {Const, NewId, NewLit}.

parse_first_token(Encod) ->
  parse_first_token(Encod, []).

parse_first_token([$ | Rest], Acc) ->
  {lists:reverse(Acc), Rest};

parse_first_token([L | Rest], Acc) ->
  parse_first_token(Rest, [L | Acc]).

parse_rest([N1, N2, N3, N4, N5, N6, $., Lit]) ->
  {[N1, N2, N3, N4, N5, N6], [Lit]}.