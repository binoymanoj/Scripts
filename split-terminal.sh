#!/bin/bash

# Start a new tmux session named "dev" with horizontal split
qterminal --execute tmux new-session -d -s dev \; \
  send-keys 'echo hello' C-m \; \
  split-window -h \; \
  send-keys 'neofetch' C-m \; \
  attach

