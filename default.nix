with import <nixpkgs> {};

# nix-build .dotfiles/default.nix
# nix-env --set /nix/store/9l8kz3pvj7mnhirl8z9qhi0mr9206lfq-default
buildEnv {
  name = "default";
  paths = [
    dhall
    kubectl
    nix
  ];
}
