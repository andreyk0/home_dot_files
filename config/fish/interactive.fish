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

function zephyr_setup
    # --- 1. Define Paths ---
    # Path to the Zephyr environment script (zephyr-env.sh)
    set -l Z_ENV_SCRIPT "$HOME/work/zephyrproject/zephyr/zephyr-env.sh"
    # Path to the Python virtual environment's fish activation script
    set -l VENV_ACTIVATE_SCRIPT "$HOME/work/zephyrproject/.venv/bin/activate.fish"

    if not test -f "$Z_ENV_SCRIPT"
        echo "Error: Zephyr environment script not found at $Z_ENV_SCRIPT" >&2
        return 1
    end

    # --- 2. Set SDK Path (Globally Exported) ---
    # Setting the SDK path directly here overrides any system defaults
    set -gx ZEPHYR_SDK_INSTALL_DIR "$HOME/work/zephyrproject/zephyr-sdk-0.17.4"
    echo "Set ZEPHYR_SDK_INSTALL_DIR to: $ZEPHYR_SDK_INSTALL_DIR"

    # --- 3. Activate Python Venv (Fish-specific) ---
    if test -f "$VENV_ACTIVATE_SCRIPT"
        echo "Activating Zephyr Python virtual environment..."
        # Source the fish activation script. This updates PATH and sets VIRTUAL_ENV.
        source "$VENV_ACTIVATE_SCRIPT"
    else
        echo "Warning: Python VENV activation script not found at $VENV_ACTIVATE_SCRIPT. west and other tools may fail." >&2
    end


    # --- 4. Source Zephyr Build Environment (via Bash) ---
    echo "Setting up Zephyr build environment..."
    # Execute the Bash script and extract exported variables
    for var in (bash -c "source $Z_ENV_SCRIPT; env -0" | string split0)
        # Import ZEPHYR_* variables and update PATH from the Bash script
        if string match -q 'ZEPHYR_*=*' "$var"
            set -gx (string split '=' $var)
        end
        if string match -q 'PATH=*' "$var"
            set -gx (string split '=' $var)
        end
    end

    echo "--- Zephyr environment is ready ---"
    echo "ZEPHYR_BASE: $ZEPHYR_BASE"
    echo "SDK path verified."
end
