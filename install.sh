#!/usr/local/bin/bash

pwd=$(pwd)

test -f ~/.bash_aliases && mv ~/.bash_aliases ~/.bash_aliases.bak
test -f ~/.tmux.conf && mv ~/.tmux.conf ~/.tmux.conf.bak
test -f ~/.vimrc && mv ~/.vimrc ~/.vimrc.bak

ln -s $pwd/bash_aliases ~/.bash_aliases
ln -s $pwd/tmux.conf ~/.tmux.conf
ln -s $pwd/.vimrc ~/.vimrc

