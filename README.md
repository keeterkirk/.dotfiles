# dotfiles

Stow-based dotfiles for Arch Linux (i3wm + polybar) and macOS, sharing
Alacritty + Tmux + Neovim + Zsh.

## Quick Start

Works on a fresh Endeavour/Arch install or a fresh Mac. `setup` detects the OS
(`uname -s`) and installs packages with `yay` (Linux) or Homebrew + `Brewfile`
(macOS), then runs `stow_all`.

Before running the below commands:

* Make sure you can clone from GitHub by adding your SSH key to your profile.
  `.gitconfig` rewrites `https://github.com/` to SSH, so plugin installs and
  pushes fail until the key is set up.
* Clone to `~/.dotfiles` (configs reference that path). On a Mac, don't put it
  in `~/Desktop` or `~/Documents` if iCloud Desktop & Documents sync is on.

```bash
git clone git@github.com:keeterkirk/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash setup
```

`stow_all` stows `packages/common` plus `packages/linux` or `packages/darwin`.
Re-run it any time; it always targets `$HOME`.

## Per-OS and per-machine config

| Where | Loaded when | Use for |
|---|---|---|
| `packages/{common,linux,darwin}` | `stow_all` | Which stow packages a machine gets |
| `zsh/.zsh/os/{linux,darwin}.zsh` | `.zshrc`, by `$DOTFILES_OS` | OS-specific shell setup |
| `zsh/.zsh/hosts/<host>.zsh` | `.zshenv`, by `$DOTFILES_HOST` | Committed per-machine env (e.g. `RSPEC_CORES`) |
| `~/.zshenv.local`, `~/.zshrc.local`, `~/.aliases.local`, `~/.gitconfig.local`, `~/.secrets` | always, if present | Uncommitted per-machine settings and secrets |

`$DOTFILES_HOST` is `hostname -s` on Linux and `scutil --get LocalHostName` on
macOS. `~/.gitconfig.local` should hold your `[user]` name and email.

## Dependencies

### Required Ruby Gems

Some shell functions require Ruby gems to be installed:

```bash
# git-up - Used by the 'dev' shell function for smart git updates
gem install git-up
```

The `dev` function uses `git-up` to checkout the main branch and update it. Without this gem, you'll get a "command not found: git-up" error.

## Documentation

- **[ARCHITECTURE.md](ARCHITECTURE.md)** - Complete guide to how this dotfiles system works (stow, directory structure, troubleshooting)
- **[CHANGELOG.md](CHANGELOG.md)** - History of significant changes
- **[bin/VOICE_TO_TEXT_README.md](bin/bin/VOICE_TO_TEXT_README.md)** - Voice-to-text system docs (experimental)

## Structure

```
.dotfiles/
├── alacritty/        # Terminal emulator
├── alacritty-macos/  # macOS-only Alacritty overrides (imported by alacritty.toml)
├── bin/              # Custom scripts (symlink to ~/bin/)
├── git/              # Git config
├── i3/               # Window manager (Linux)
├── neovim/           # Editor
├── polybar/          # Status bar (Linux)
├── tig/              # Git TUI
├── tmux/             # Terminal multiplexer
├── zsh/              # Shell
├── packages/         # Stow package lists per OS
├── setup_steps/      # arch.sh, macos.sh + shared steps
└── Brewfile          # macOS packages
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

# Add to the package list for the OSes that should get it
echo "newapp" >> packages/common   # or packages/linux, packages/darwin
```

## rspec

To run `rspec` with more or less cores, set `RSPEC_CORES` in
`zsh/.zsh/hosts/<host>.zsh` (committed) or `~/.zshenv.local` (defaults to 12).
