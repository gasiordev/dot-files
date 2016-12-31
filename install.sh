#!/usr/local/bin/bash

pwd=$(pwd)

test -f ~/.bash_aliases && mv ~/.bash_aliases ~/.bash_aliases.bak
test -f ~/.tmux.conf && mv ~/.tmux.conf ~/.tmux.conf.bak
test -f ~/.vimrc && mv ~/.vimrc ~/.vimrc.bak

cp -rf $pwd/bash_aliases ~/.bash_aliases
cp -rf $pwd/tmux.conf ~/.tmux.conf
cp -rf $pwd/vimrc ~/.vimrc

grep -q 'source ~/.bash_aliases' ~/.profile || echo 'source ~/.bash_aliases' >> ~/.profile

