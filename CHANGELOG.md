# Changelog

All notable changes to this dotfiles repository.

## [2026-10-03] - macOS Support

### Added
- `packages/{common,linux,darwin}` stow lists; `stow_all` now targets `$HOME`
  from any clone location
- `setup` dispatches by OS to `setup_steps/arch.sh` (old package list) or
  `setup_steps/macos.sh` (Xcode CLT, Homebrew, `Brewfile`, Alacritty DMG)
- `zsh/.zsh/os/{linux,darwin}.zsh` and `zsh/.zsh/hosts/<host>.zsh`, with
  `DOTFILES_OS` / `DOTFILES_HOST` set in `.zshenv`
- `alacritty-macos` package (Option-as-Alt, Hack Nerd Font)
- Host file for Kirks-MacBook-Air (`RSPEC_CORES=10`)

### Changed
- Linux-only env (Android Studio/JDK, LIBGL, voice-to-text credentials) moved
  from `.zshrc` to `os/linux.zsh`; CUDA/linuxbrew PATH guarded to Linux
- tmux and Alacritty use `/bin/zsh`; Alacritty starts a login shell
- tmux copy uses `pbcopy` on macOS, `xclip` on Linux (`copy-command`)
- `.gitconfig` calls `gh` from PATH instead of `/usr/bin/gh`
- fzf integration prefers `fzf --zsh`, keeping the old paths as fallbacks
- `DEV_DIR` (default `~/dev`) drives `WORK_DIR` and the `agent` function
- `RSPEC_CORES`, `DEV_DIR`, `WORK_DIR` are overridable defaults
- Arch list adds `fzf` and `git-delta` (the git pager)
- `setup_steps/ruby.sh` builds Ruby on macOS with `ac_cv_func_pipe2=no
  ac_cv_func_dup3=no`: macOS 26's SDK makes configure detect them, but they
  resolve to NULL at runtime and miniruby segfaults mid-build

### Fixed
- PATH added `~/.dotfiles/bin` (empty) instead of `~/bin`; tmux `prefix y`
  pointed at the nonexistent `~/.dotfiles/bin/wt`
- `opentmux` ran in non-terminal shells (editors, agents, scripts) and created
  stray tmux sessions; it now needs a TTY
- `gdm` used `$base_branch` without setting it
- `git-up` called `base_branch`, which scripts don't load
- `pa` used GNU-only `ls --indicator-style`
- `wd` used `\s` in sed, which BSD sed doesn't support
- `ka` parsed `ps aux` with `cut -d' '` (wrong column); now `pkill -f`
- `setup_steps/ruby.sh` called `chruby` without loading it, and kept going
  (installing gems into system Ruby) when the build failed
- `setup_steps/shell.sh` would `chsh` to `/usr/bin/zsh` even when already zsh

## [2026-02-13] - Dependencies Documentation & git-up

### Added
- **Dependencies section** in README.md documenting required Ruby gems
- **git-up troubleshooting** in ARCHITECTURE.md for "command not found" errors
- Installed `git-up` gem (v0.5.12) for the `dev` shell function

### Fixed
- "command not found: git-up" error when using `dev` shell function
- Documentation now explicitly lists gem dependencies

## [2026-02-13] - Bin Directory Restructuring & Voice-to-Text

### Changed
- **Restructured `bin/` directory** to fix stow symlink behavior
  - Moved all scripts from `bin/script` to `bin/bin/script`
  - Now scripts properly symlink to `~/bin/` instead of `~/`
  - Updated `stow_all` to include bin package

### Added
- **Voice-to-Text System** (experimental, currently disabled)
  - `bin/bin/voice-to-text` - Google Cloud Speech-to-Text streaming script
  - `bin/bin/voice-to-text-setup` - Interactive setup script
  - `bin/bin/VOICE_TO_TEXT_README.md` - Complete documentation
  - Uses Google Cloud API for fast transcription (same speed as Web Speech API)
  - Types transcribed text into active window using xdotool

- **Documentation**
  - `ARCHITECTURE.md` - Comprehensive guide to dotfiles structure and stow usage
  - `CHANGELOG.md` - This file

### Status
- Voice-to-text **disabled** due to Google Cloud permissions issues
- i3 keybinding commented out: `# bindsym $mod+space exec ~/bin/voice-to-text`
- Can be enabled later after resolving Google Cloud setup

### Technical Details
The bin restructuring caused git to show all files as "deleted" and "untracked", but running `git add -A` correctly detected them as renames:
- `bin/cheat` → `bin/bin/cheat`
- `bin/docker_or_local` → `bin/bin/docker_or_local`
- etc.

### Migration Path
```bash
# Old structure (wrong)
~/.dotfiles/bin/cheat → ~/cheat

# New structure (correct)
~/.dotfiles/bin/bin/cheat → ~/bin/cheat
```

### Future Work
- [ ] Resolve Google Cloud permissions for voice-to-text
- [ ] Consider alternative STT solutions (Azure, AWS, Vosk)
- [ ] Test voice-to-text with Claude Code sessions

---

## Previous Changes

No formal changelog existed before 2026-02-13. See git history for details:
```bash
git log --oneline --all
```
