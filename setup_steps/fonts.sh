install_nerd_font() {
  if fc-list | grep -qi "$1 Nerd Font"; then
    echo "skipping install $1 Nerd Font: already installed"
  else
    echo "installing $1 Nerd Font"
    tmp=$(mktemp -d)
    curl -fsSL -o "$tmp/$1.zip" \
      "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$1.zip"
    unzip -oq "$tmp/$1.zip" -d "$HOME/.local/share/fonts/${1}NerdFont" -x "*.md" "LICENSE*"
    rm -rf "$tmp"
    fc-cache -f "$HOME/.local/share/fonts" >/dev/null
  fi
  echo ""
}

mkdir -p ~/.local/share/fonts

# Portable across distros (the yay "ttf-hack-nerd" package in ./setup is Arch-only).
install_nerd_font "Hack"
