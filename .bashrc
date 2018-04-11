if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

alias e='vim -u ~/.vimrc'

alias ga='git add'
alias gc='git commit'
alias gp='git pull'
alias go='git push'
alias gg='git clone'
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

dev() {
  export DEV_MODE=1
  ps1
}

undev() {
  export DEV_MODE=0
  ps1
}

ps1() {
  cols=`tput cols`
  if [[ $cols -gt 80 ]]; then
    export PS1="\e[0;35m\d \t \e[1;34m\u\e[0;36m@\h\e[m \e[0;33m\w\e[m \$(if ! git diff-index --quiet HEAD -- >/dev/null 2>&1; then echo '\e[0;31m'; else echo '\e[0;32m'; fi)\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\e[m$ "
  else
    export PS1="\e[1;34m\u\e[0;36m@\h\e[m \e[0;33m\W\e[m$ "
  fi
  if [[ DEV_MODE -eq 1 ]]; then
    export PS1="\e[0;33m\w\e[m \$(if ! git diff-index --quiet HEAD -- >/dev/null 2>&1; then echo '\e[0;31m'; else echo '\e[0;32m'; fi)\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\e[m$ "
  fi
}

ps1

