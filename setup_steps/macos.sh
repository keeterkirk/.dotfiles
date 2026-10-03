# vi: set ft=sh :
# macOS packages. Sourced by ./setup on Darwin.

if ! xcode-select -p >/dev/null 2>&1; then
  echo "installing Xcode command line tools (re-run setup when it finishes)"
  xcode-select --install
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

brew bundle --file="$DOTFILES/Brewfile"

# The Homebrew alacritty cask was disabled (fails Gatekeeper), so install the
# official release DMG and clear the quarantine flag ourselves.
install_alacritty() {
  if [ -d /Applications/Alacritty.app ]; then
    echo "skipping install Alacritty: already installed"
  else
    echo "installing Alacritty"
    tmp=$(mktemp -d)
    url=$(curl -fsSL https://api.github.com/repos/alacritty/alacritty/releases/latest \
      | grep -o '"browser_download_url": *"[^"]*\.dmg"' | sed 's/.*"\(http[^"]*\)"/\1/')
    curl -fsSL -o "$tmp/Alacritty.dmg" "$url"
    hdiutil attach -quiet -nobrowse -mountpoint "$tmp/mnt" "$tmp/Alacritty.dmg"
    cp -R "$tmp/mnt/Alacritty.app" /Applications/
    hdiutil detach -quiet "$tmp/mnt"
    xattr -dr com.apple.quarantine /Applications/Alacritty.app
    rm -rf "$tmp"
  fi
  echo ""
}

install_alacritty
