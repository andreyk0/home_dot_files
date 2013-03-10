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

# Prefer inc_append_history of share_history for consistent per-window behavior
unsetopt share_history     # Don't share history real-time between instances.
setopt inc_append_history  # Each instance has its own history at run time, but global history file (for future invocations) is appended in real-time
# Some history settings missing from lib/history.zsh
setopt hist_ignore_dups    # Don't store sequential duplicate lines
setopt hist_find_no_dups   # Don't cycle through dupes during history search
setopt hist_reduce_blanks  # Trim before saving
setopt hist_no_store       # Don't save invocation of history itself
setopt hist_no_functions   # Don't save ZSH function definitions


PS1='%~# '
REPORTTIME=10

[[ -z $TMUX ]] && tmux -2 -u
