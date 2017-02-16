alias e='vim -u ~/.vimrc'

alias aa='git add'
alias cc='git commit'
alias pp='git pull'
alias oo='git push'
alias gg='git clone'
alias ss='git status'
alias dd='git diff'

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


