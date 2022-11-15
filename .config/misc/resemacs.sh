#!/usr/bin/env bash

killall emacs && \emacs --daemon && nohup emacsclient -c >&/dev/null &
