if status is-interactive
  fish_vi_key_bindings

  source (starship init fish --print-full-init | psub)
  zoxide init fish | source
end

alias cat 'bat -p'
alias fda 'fd -uH'
alias g git
alias gs 'git status'
alias hx helix
alias jc 'just --choose'
alias j just
alias julia 'julia -p auto'
alias la 'exa -g -a'
alias ll 'exa -g -l --git'
alias ls 'exa -g'
alias m 'mise run'
alias open xdg-open
alias rga 'rg --no-ignore -.'
alias run-help man
alias tree 'exa --git-ignore -T'
alias trm trash-put
alias wbat 'bat --wrap never'
alias which-command whence
alias zp 'z $(project-root)'
alias Z 'zellij action rename-tab $(basename $(pwd))'
