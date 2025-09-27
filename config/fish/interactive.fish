fish_vi_key_bindings

bind -M insert right forward-word

if test -e $HOME/.dircolors
    eval (dircolors -b ~/.dircolors | sed -e 's/^/set -gx /' -e 's/=/ /; s/;$//')
end

if type -q starship
    source (starship init fish --print-full-init | psub)
end

if type -q zoxide
    zoxide init fish | source
end

if type -q direnv
direnv hook fish | source
end

if test -z "$SSH_CLIENT"
    set -gx GPG_TTY (/usr/bin/tty)
    set -gx SSH_AUTH_SOCK "/run/user/$(id -u)/gnupg/S.gpg-agent.ssh"
end

if type -q exa
    alias ls 'exa -g'
    alias ll 'exa -g -l --git'
    alias la 'exa -g -a'
    alias tree 'exa --git-ignore -T'
end

if type -q fd
    alias fda 'fd -uH'
end

if type -q rg
    alias rga 'rg --no-ignore -.'
end

if type -q bat
    alias cat 'bat -p'
    alias wbat 'bat --wrap=never'
end

if type -q just
    alias j 'just'
end

if type -q uv
    set -gx UV_LINK_MODE copy
end

alias g=git
alias gs='git status'

alias trm='trash-put'
alias open='xdg-open'

alias zp='z $(project-root)'

function o --wraps "$argv"
    $argv &| tee /tmp/out.$fish_pid
    echo "bat /tmp/out.$fish_pid"
end

if type -q zellij
    source (zellij setup --generate-completion=fish) 2>/dev/null
    alias Z='zellij action rename-tab $(basename $(pwd))'
end

if type -q zoxide
    zoxide init fish | source
end

if test -e $HOME/work/esp/esp-idf/export.fish
    alias esp_get_idf='. $HOME/work/esp/esp-idf/export.fish'
    alias idf=idf.py
end

function esp_get_rust
    # from ~/export-esp.sh
    # Set LIBCLANG_PATH
    set -gx LIBCLANG_PATH "/home/andrey/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-20.1.1_20250829/esp-clang/lib"
    # Prepend the new path to the existing PATH
    set -gx PATH "/home/andrey/.rustup/toolchains/esp/xtensa-esp-elf/esp-15.2.0_20250920/xtensa-esp-elf/bin" $PATH
end

function reset
  clear
  tput reset
end
