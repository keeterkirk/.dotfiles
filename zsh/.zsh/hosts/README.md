# Per-host zsh settings

`~/.zsh/hosts/<host>.zsh` is sourced from `.zshenv` when `<host>` matches
`$DOTFILES_HOST` (`hostname -s` on Linux, `scutil --get LocalHostName` on
macOS). It runs before the overridable defaults, so set things like:

```zsh
export RSPEC_CORES=8
export DEV_DIR=$HOME/code
```

Keep secrets out of here; use `~/.secrets` or `~/.zshenv.local` instead.
