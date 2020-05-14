if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

alias e='vim -u ~/.vimrc'

alias gs='git status'
alias gd='git diff'

alias c='clear'

cd() { builtin cd "$@"; ll; }
mcd () { mkdir -p "$1" && cd "$1"; }
alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias .6='cd ../../../../../../'

[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

