%%%-------------------------------------------------------------------
%%% @author jiarj
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. 五月 2017 16:23
%%%-------------------------------------------------------------------
-module(gws_user_admin).
-author("jiarj").
-behavior(gen_server).
-record(state, {}).
-define(SERVER, ?MODULE).

-export([get_router/0,start_link/0]).
%% API
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).


get_router()->
  gen_server:call(?SERVER, get_router).

start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

init([]) ->
  {ok, #state{}}.

handle_call(get_router, _From, State) ->
  Routes = [{"/user_admin/admin_require", admin_require_handler, []}
          ,{"/user_admin/user_require", user_require_handler, []}
  ],

  {reply, Routes, State};
handle_call(_, _From, State) ->
  {reply, ok, State}.

handle_cast(_Request, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  io:format("gws_user-admin terminated.~n", []),
  ok = application:stop(cowboy),
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

