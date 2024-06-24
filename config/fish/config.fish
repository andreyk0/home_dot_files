if status is-interactive
  fish_vi_key_bindings
  source (starship init fish --print-full-init | psub)
  zoxide init fish | source
end
