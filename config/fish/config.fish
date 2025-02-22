set -gx PATH \
    ~/sbin \
    ~/bin \
    ~/.local/bin \
    ~/.cargo/bin \
    ~/.ghcup/bin \
    ~/.config/emacs/bin \
    ~/.local/share/coursier/bin \
    /sbin \
    /bin \
    /usr/sbin \
    /usr/bin \
    /usr/local/sbin \
    /usr/local/bin \
    $PATH

if not set -q TMPDIR; and test -d /run/user/(id -u)
    set -gx TMPDIR /run/user/(id -u)
end

set -gx EDITOR e
set -gx GIT /usr/bin/git
set -gx LOCALE_ARCHIVE /usr/lib/locale/locale-archive
set -gx CLOUDSDK_PYTHON_SITEPACKAGES 1

set -gx GOPATH "$HOME/.cache/go"

if test "$XDG_SESSION_TYPE" = wayland
    set -gx MOZ_ENABLE_WAYLAND 1
end

if test -e $HOME/.fishenvlocal
   source $HOME/.fishenvlocal
end

if status is-interactive
  source $HOME/.dotfiles/config/fish/interactive.fish
end
