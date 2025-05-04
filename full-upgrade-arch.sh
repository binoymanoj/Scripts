#!/bin/bash

sudo pacman -Syyu --noconfirm && yay -Syu --aur --noconfirm

# for clearing yay cache
yay -Sc
