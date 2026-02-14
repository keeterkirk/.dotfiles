# dotfiles

Stow-based dotfiles for Arch Linux + i3wm + Alacritty + Tmux + Neovim

## Quick Start

These instructions are for a fresh Endeavour GNOME install.

Before running the below commands:

* Make sure you can clone from GitHub by adding your SSH key to your profile.

```bash
git clone git@github.com:keeterkirk/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash setup
./stow_all
```

## Documentation

- **[ARCHITECTURE.md](ARCHITECTURE.md)** - Complete guide to how this dotfiles system works (stow, directory structure, troubleshooting)
- **[CHANGELOG.md](CHANGELOG.md)** - History of significant changes
- **[bin/VOICE_TO_TEXT_README.md](bin/bin/VOICE_TO_TEXT_README.md)** - Voice-to-text system docs (experimental)

## Structure

```
.dotfiles/
├── alacritty/     # Terminal emulator
├── bin/           # Custom scripts (symlink to ~/bin/)
├── git/           # Git config
├── i3/            # Window manager
├── neovim/        # Editor
├── polybar/       # Status bar
├── tig/           # Git TUI
├── tmux/          # Terminal multiplexer
└── zsh/           # Shell
```

## How It Works

This uses [GNU Stow](https://www.gnu.org/software/stow/) to manage symlinks:

```
~/.dotfiles/git/.gitconfig  →  ~/.gitconfig
~/.dotfiles/bin/bin/cheat   →  ~/bin/cheat
```

See [ARCHITECTURE.md](ARCHITECTURE.md) for complete details.

## Adding New Configs

```bash
# Create package structure
mkdir -p ~/.dotfiles/newapp/.config/newapp

# Add config
cp ~/.config/newapp/config.yml ~/.dotfiles/newapp/.config/newapp/

# Stow it
cd ~/.dotfiles
stow -vv newapp

# Add to stow_all
echo "stow -vv newapp" >> stow_all
```

## rspec

To run `rspec` with more or less cores, set `RSPEC_CORES` in `~/.zshenv`
