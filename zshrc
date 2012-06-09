. ~/.shenv

autoload -U compinit
compinit
setopt completeinword
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'
autoload select-word-style
select-word-style shell
setopt auto_cd

setopt interactivecomments # pound sign in interactive prompt

# superglobs
setopt extendedglob
unsetopt caseglob

HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt incappendhistory 
setopt sharehistory
setopt extendedhistory

PS1='%~# '
REPORTTIME=10

[[ -z $TMUX ]] && tmux
