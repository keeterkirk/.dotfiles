set_default_shell() {
  if [ "$(basename "$SHELL")" = "zsh" ]; then
    echo "skipping change shell: shell is already $SHELL"
  else
    echo "setting shell to $1"
    chsh -s "$1"
  fi
  echo ""
}

# /bin/zsh exists on macOS and on merged-/usr Linux (Arch, Ubuntu 20.04+).
set_default_shell "/bin/zsh"
