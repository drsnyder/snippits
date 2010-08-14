#!/bin/bash
tmux start-server
tmux new-session -d -s tpopp -n git
tmux new-window -ttpopp:1 -n vim
tmux new-window -ttpopp:2 -n build
tmux new-window -ttpopp:3 -n racket
tmux new-window -ttpopp:4 -n clojure

tmux send-keys -ttpopp:0 'cd ~/playground/snippits/tpop; clear' C-m
tmux send-keys -ttpopp:1 'cd ~/playground/snippits/tpop; clear' C-m
tmux send-keys -ttpopp:2 'cd ~/playground/snippits/tpop; clear' C-m
tmux send-keys -ttpopp:3 'cd ~/playground/snippits/tpop; clear' C-m
tmux send-keys -ttpopp:4 'cd ~/playground/snippits/tpop; clear' C-m

tmux select-window -ttpopp:0
tmux attach-session -d -ttpopp
