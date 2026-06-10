#!/bin/bash
cd client
tmux new-session -d -s boucles 'bash ./clisten.sh'
cd ..
tmux split-window -h  'bash columba2.sh'

tmux attach-session -t boucles