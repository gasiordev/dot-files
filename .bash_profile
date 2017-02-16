alias e='vim -u ~/.vimrc'

alias aa='git add'
alias cc='git commit'
alias pp='git pull'
alias oo='git push'
alias gg='git clone'
alias ss='git status'
alias dd='git diff'

alias c='cat'

cd() { builtin cd "$@"; ll; }
alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias .6='cd ../../../../../../'

