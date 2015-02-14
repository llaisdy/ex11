-module(hello_world).

%%% Hello_world template
%%% Created: 2003-12-29 by joe@sics.se

%%% Cut and paste from this to make your first windows program

-include("ex11_lib.hrl").

-export([start/0]).

start() ->
    spawn_link(fun() -> init() end).

init() ->
    {ok, Pid} = ex11_lib:xStart("3.3"),
    Win  = ex11_lib:xCreateSimpleWindow(Pid, 10, 10, 300, 100, ?XC_arrow, 
					ex11_lib:xColor(Pid, ?wheat2)),
    Font = ex11_lib:xEnsureFont(Pid, "9x15"),  
    Pen  = ex11_lib:xCreateGC(Pid, [{function, copy},
				    {font, Font},
				    {fill_style, solid},
				    {foreground, ex11_lib:xColor(Pid, ?DarkBlue)}]),
    Cmd =  ex11_lib:ePolyText8(Win, Pen, 10, 35, "Hello World"),
    ex11_lib:xDo(Pid, Cmd),
    ex11_lib:xDo(Pid, ex11_lib:eMapWindow(Win)),
    ex11_lib:xFlush(Pid),
    loop(Pid, Win, Cmd).

loop(Pid, Win, Cmd) ->
    receive
	{event,Win,expose,_} ->
	    io:format("expose event sending data~n"),
	    ex11_lib:xDo(Pid, Cmd),
	    ex11_lib:xFlush(Pid),
	    loop(Pid, Win, Cmd);
	Any ->
	    io:format("Here:~p~n",[Any]),
	    loop(Pid, Win, Cmd)
    end.



   









