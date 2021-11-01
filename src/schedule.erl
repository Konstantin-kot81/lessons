%%%-------------------------------------------------------------------
%%% @author kot
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Oct 2021 05:55
%%%-------------------------------------------------------------------
-module(schedule).
-author("kot").

%% API

-export([times/0]).

-export([go_kindergarten_together/0]).
-export([go_kindergarten_together/1]).

-export([go_back_single/0]).
-export([go_back_single/1]).

-export([kindergarten/0]).
-export([kindergarten/1]).

-export([total_all/0]).
-export([total_all/1]).

-define(SecondsInMin, 60).

-record(day, {
  with_sneg_2_kg = 0,
  back_4m_kg = 0,
  sneg_in_kg = 0,
  go_sneg_2_kg = 0,
  with_sneg_4m_kg = 0,
  simple
}).

%%------------------------------------------------------------------------------
times() ->
  [
    #day{with_sneg_2_kg = 14, back_4m_kg = 10, sneg_in_kg = 600, with_sneg_4m_kg = 18, go_sneg_2_kg = 9},
    #day{with_sneg_2_kg = 12, back_4m_kg = 11, sneg_in_kg = 580, with_sneg_4m_kg = 22, go_sneg_2_kg = 11},
    #day{with_sneg_2_kg = 16, back_4m_kg = 8, sneg_in_kg = 610, with_sneg_4m_kg = 12, go_sneg_2_kg = 12},
    #day{with_sneg_2_kg = 15, back_4m_kg = 13, sneg_in_kg = 587, with_sneg_4m_kg = 25, go_sneg_2_kg = 10},
    #day{with_sneg_2_kg = 11, back_4m_kg = 12, sneg_in_kg = 608, with_sneg_4m_kg = 15, go_sneg_2_kg = 13}
  ].
%%------------------------------------------------------------------------------
go_kindergarten_together() ->
  go_kindergarten_together(times()).

go_kindergarten_together(Time) ->
  go_kindergarten_together(Time, 0).

go_kindergarten_together([#day{with_sneg_2_kg = GoTghr, with_sneg_4m_kg = BackTghr} | Time], SumAcc) ->
  go_kindergarten_together(Time, (GoTghr + BackTghr) + SumAcc);

go_kindergarten_together([], SumAcc) ->
  SumAcc / ?SecondsInMin.
%%------------------------------------------------------------------------------
go_back_single() ->
  go_back_single(times()).

go_back_single(Time) ->
  go_back_single(Time, 0).

go_back_single([{_, _, BackHome, _, _, GoSingle} | Time], SumAcc) ->
  go_back_single(Time, (BackHome + GoSingle) + SumAcc);

go_back_single([], SumAcc) ->
  SumAcc / ?SecondsInMin.
%%------------------------------------------------------------------------------
kindergarten() ->
  kindergarten(time()).

kindergarten(Time) ->
  kindergarten(Time, 0).

kindergarten([#day{sneg_in_kg = Kg} | Time], SumAcc) ->
  kindergarten(Time, Kg + SumAcc);

kindergarten([], SumAcc) ->
  SumAcc / ?SecondsInMin.
%%------------------------------------------------------------------------------
total_all() ->
  total_all(time()).

total_all(Time) ->
  Go_kt = go_kindergarten_together(Time),
  Go_bs = go_back_single(Time),
  Kt = kindergarten(Time),
  [Go_kt, Go_bs, Kt].