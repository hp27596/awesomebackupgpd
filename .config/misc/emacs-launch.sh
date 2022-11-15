#!/bin/sh

if [[ $(pgrep emacs --exact) == '' ]]; then
    \emacs --daemon
fi

if [[ $(pgrep emacsclient) == '' ]]; then
    # \emacsclient -c -e '(dashboard-refresh-buffer)' &
    nohup \emacsclient -c >&/dev/null &
else
    nohup \emacsclient -e '(progn (+workspace/new)(find-file "'$@'"))' >&/dev/null &
fi

echo 'local awful = require("awful") ; awful.screen.focused().tags[2]:view_only()' | awesome-client
