# Dotfiles Architecture

**Last Updated:** 2026-02-13
**For:** Future Claude sessions and reference

## Overview

This is a **stow-based dotfiles system** for managing configuration files across a Linux system (Arch/Endeavour OS with i3wm).

## How Stow Works

[Stow](https://www.gnu.org/software/stow/) creates symlinks from your home directory to files in `~/.dotfiles/`.

### Directory Structure Pattern

Stow uses the **package directory structure** to determine where to create symlinks:

```
~/.dotfiles/PACKAGE/path/to/file  →  ~/path/to/file
              ^^^^^^^                  (package name is removed)
```

### Examples

**Example 1: Git config**
```
~/.dotfiles/git/.gitconfig  →  ~/.gitconfig
```

**Example 2: Alacritty config**
```
~/.dotfiles/alacritty/.config/alacritty/alacritty.toml  →  ~/.config/alacritty/alacritty.toml
```

**Example 3: Bin scripts (the tricky one!)**
```
~/.dotfiles/bin/bin/cheat  →  ~/bin/cheat
                 ^^^           ^^^
            (extra bin!)   (symlink location)
```

## Package Structure

Each subdirectory in `~/.dotfiles/` is a "package":

```
.dotfiles/
├── alacritty/     # Terminal emulator config
├── bin/           # Custom scripts and executables
├── git/           # Git configuration
├── i3/            # i3 window manager config
├── neovim/        # Neovim editor config
├── polybar/       # Status bar config
├── tig/           # Git TUI config
├── tmux/          # Terminal multiplexer config
└── zsh/           # Zsh shell config
```

### Managing Packages

**Install all packages:**
```bash
cd ~/.dotfiles
./stow_all
```

**Install specific package:**
```bash
cd ~/.dotfiles
stow -vv bin
```

**Uninstall package:**
```bash
cd ~/.dotfiles
stow -D bin
```

**Reinstall package (useful after structure changes):**
```bash
cd ~/.dotfiles
stow -R bin
```

## The `bin` Directory Restructuring (2026-02-13)

### Problem

Originally, bin scripts were structured like this:
```
~/.dotfiles/bin/cheat
~/.dotfiles/bin/docker_or_local
~/.dotfiles/bin/extract
```

This caused stow to create symlinks at:
```
~/cheat          ❌ Wrong! Clutters home directory
~/docker_or_local
~/extract
```

### Solution

Restructured to nest scripts one level deeper:
```
~/.dotfiles/bin/bin/cheat
~/.dotfiles/bin/bin/docker_or_local
~/.dotfiles/bin/bin/extract
```

Now stow creates symlinks at:
```
~/bin/cheat      ✅ Correct! Organized in ~/bin/
~/bin/docker_or_local
~/bin/extract
```

### Why The Extra `/bin/` Layer?

Stow removes the **first** directory (the package name) and replicates the rest:

```
~/.dotfiles/bin/bin/cheat
            └── └── └────
            1   2   3
```

1. Package name (`bin`) - removed by stow
2. Target directory (`bin`) - becomes `~/bin/`
3. File name (`cheat`) - becomes `~/bin/cheat`

### Git Changes From Restructuring

When this restructuring happened, git showed:
- **Deleted:** All old paths (`bin/cheat`, `bin/docker_or_local`, etc.)
- **Untracked:** New directory (`bin/bin/`)
- **Modified:** `stow_all` (added bin package), `i3/.config/i3/config` (voice-to-text changes)

After running `git add -A`, git detected these as **renames**:
```
renamed: bin/cheat -> bin/bin/cheat
renamed: bin/docker_or_local -> bin/bin/docker_or_local
...
```

## Voice-to-Text System (Experimental)

### Status: PAUSED (2026-02-13)

An experimental voice-to-text system was added but is currently **disabled** due to Google Cloud setup issues.

### Files Added

```
bin/bin/voice-to-text              # Main Python script (streaming STT)
bin/bin/voice-to-text-setup        # Setup/installation script
bin/bin/VOICE_TO_TEXT_README.md    # Complete documentation
```

### What It Does

Uses Google Cloud Speech-to-Text API to:
1. Record audio from microphone
2. Stream to Google Cloud for transcription
3. Type the transcribed text into the active window (using xdotool)

### Why It's Disabled

- Requires Google Cloud project with Speech-to-Text API enabled
- Hit permissions issues during Google Cloud setup
- Keybinding commented out in i3 config: `# bindsym $mod+space exec ~/bin/voice-to-text`

### How To Enable (Future)

1. Resolve Google Cloud permissions/setup
2. Set `GOOGLE_APPLICATION_CREDENTIALS` environment variable
3. Uncomment keybinding in `i3/.config/i3/config`
4. Reload i3: `$mod+Ctrl+r`

See `~/bin/VOICE_TO_TEXT_README.md` for complete setup instructions.

## Common Patterns

### Adding a New Package

1. Create directory structure:
   ```bash
   mkdir -p ~/.dotfiles/newpackage/.config/newapp
   ```

2. Add config files:
   ```bash
   cp ~/.config/newapp/config.yml ~/.dotfiles/newpackage/.config/newapp/
   ```

3. Stow it:
   ```bash
   cd ~/.dotfiles
   stow -vv newpackage
   ```

4. Add to `stow_all`:
   ```bash
   echo "stow -vv newpackage" >> stow_all
   ```

### Adding Scripts to `bin`

**Important:** Scripts must go in `bin/bin/`, not `bin/`!

```bash
# Create new script
vim ~/.dotfiles/bin/bin/my-new-script
chmod +x ~/.dotfiles/bin/bin/my-new-script

# Restow to create symlink
cd ~/.dotfiles
stow -R bin

# Verify
ls -la ~/bin/my-new-script
```

### Checking What's Stowed

```bash
# See all symlinks in home directory
find ~ -maxdepth 3 -type l -ls 2>/dev/null | grep .dotfiles

# Check specific file
ls -la ~/.gitconfig
# Output: ~/.gitconfig -> .dotfiles/git/.gitconfig
```

## Key Configuration Files

### i3 Window Manager
- **Config:** `i3/.config/i3/config`
- **Keybindings:** All start with `$mod` (Super/Windows key)
- **Monitor setup:** `i3/.config/i3/monitors.sh`

### Polybar Status Bar
- **Config:** `polybar/.config/polybar/config.ini`
- **Launch script:** `polybar/.config/polybar/launch.sh`

### Zsh Shell
- **Config:** `zsh/.zshrc`
- **Environment:** `zsh/.zshenv`
- **Aliases:** In `.zshrc`

### Tmux
- **Config:** `tmux/.tmux.conf`
- **Open script:** `bin/bin/opentmux`

### Neovim
- **Config:** `neovim/.config/nvim/init.lua`

## Setup on New Machine

```bash
# 1. Clone dotfiles
git clone git@github.com:keeterkirk/.dotfiles.git ~/.dotfiles

# 2. Run setup script
cd ~/.dotfiles
bash setup

# 3. Stow all packages
./stow_all

# 4. Install dependencies (optional)
# See individual package READMEs or setup scripts
```

## Troubleshooting

### Stow Conflicts

If stow complains about existing files:

```bash
# Option 1: Remove the conflicting file
rm ~/.gitconfig

# Option 2: Back it up first
mv ~/.gitconfig ~/.gitconfig.backup

# Then restow
stow -R git
```

### Broken Symlinks

Find and clean up broken symlinks:

```bash
find ~ -maxdepth 3 -xtype l -delete 2>/dev/null
```

### Bin Scripts Not Found

Make sure `~/bin` is in your PATH (should be automatic in `.zshrc`):

```bash
echo $PATH | grep -o "$HOME/bin"
```

If not, add to `.zshrc`:
```bash
export PATH="$HOME/bin:$PATH"
```

### "command not found: git-up"

The `dev` shell function requires the `git-up` Ruby gem:

```bash
gem install git-up
```

The `dev` function is used to quickly switch to the main branch and update it:
```bash
dev  # Equivalent to: git checkout main && git-up
```

`git-up` is a smart alternative to `git pull` that updates all your local branches and uses rebase by default.

## Best Practices

### 1. Always Use Stow
Don't manually create symlinks. Let stow manage them.

### 2. Test Before Committing
```bash
# Stow to test
stow -vv package

# Check it works
# ... test your config ...

# Then commit
git add -A
git commit -m "Add package config"
```

### 3. Document Significant Changes
Update this file when making structural changes or adding experimental features.

### 4. Use Nested Directories for Organization
If multiple files need to go in the same target directory, nest them appropriately:

```
package/.config/app/
├── config.yml
├── themes/
│   └── dark.yml
└── plugins/
    └── plugin1.lua
```

## For Future Claude Sessions

### Quick Context
- **System:** Arch Linux, i3wm, Alacritty, Tmux, Neovim
- **Package Manager:** Stow
- **Shell:** Zsh
- **Key principle:** `~/.dotfiles/PACKAGE/path/` → `~/path/`

### Common Tasks

**User wants to add a config file:**
1. Check where it lives (`~/config/app/file`)
2. Create matching structure in dotfiles (`package/.config/app/file`)
3. Stow the package
4. Add to `stow_all` if new package

**User has stow issues:**
1. Check directory structure (must mirror target location)
2. Check for conflicts (existing non-symlinked files)
3. Remember: `bin` needs `bin/bin/` structure!

**User asks about changes:**
1. Check `git status` to see what changed
2. Explain deleted + untracked might be renames
3. Use `git add -A` to let git detect renames

### Files to Check
- `stow_all` - Lists all packages
- `setup` - Initial setup script
- Individual package READMEs - Package-specific docs

## Resources

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/stow.html)
- [Managing Dotfiles with Stow](https://www.youtube.com/watch?v=y6XCebnB9gs)
- [i3 User's Guide](https://i3wm.org/docs/userguide.html)

---

**Questions?** Check the README files in individual packages, or start a new Claude session with this document for context.
