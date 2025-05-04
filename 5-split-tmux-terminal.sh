#!/bin/bash
qterminal --execute tmux new-session -d -s dev \; \
    split-window -v -p 50 \; \
    select-pane -t 0 \; \
    split-window -h -p 66 \; \
    split-window -h -p 50 \; \
    select-pane -t 3 \; \
    split-window -h -p 50 \; \
    select-pane -t 0 \; \
    send-keys 'echo "Terminal 1"' C-m \; \
    select-pane -t 1 \; \
    send-keys 'echo "Terminal 2"' C-m \; \
    select-pane -t 2 \; \
    send-keys 'echo "Terminal 3"' C-m \; \
    select-pane -t 3 \; \
    send-keys 'echo "Terminal 4"' C-m \; \
    select-pane -t 4 \; \
    send-keys 'echo "Terminal 5"' C-m \; \
    attach
