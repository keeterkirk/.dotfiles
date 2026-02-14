# Changelog

All notable changes to this dotfiles repository.

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
