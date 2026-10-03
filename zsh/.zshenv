export DOTFILES=$HOME/.dotfiles

# OS and host detection, used to load ~/.zsh/os/<os>.zsh and
# ~/.zsh/hosts/<host>.zsh. macOS `hostname` can change with the network, so
# use the stable LocalHostName there.
case "$OSTYPE" in
  darwin*)
    export DOTFILES_OS=darwin
    export DOTFILES_HOST=$(scutil --get LocalHostName 2>/dev/null || hostname -s)
    ;;
  *)
    export DOTFILES_OS=linux
    export DOTFILES_HOST=$(hostname -s 2>/dev/null || hostname)
    ;;
esac

export PATH="$HOME/bin:$HOME/opt/bin:$HOME/.local/share/bob/nvim-bin:$PATH"
if [[ $DOTFILES_OS == linux ]]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:/opt/cuda/bin:$PATH"
  export LD_LIBRARY_PATH="/opt/cuda/lib64:${LD_LIBRARY_PATH}"
else
  # bob uses the macOS data dir rather than ~/.local/share
  export PATH="$HOME/Library/Application Support/bob/nvim-bin:$PATH"
fi

export VISUAL=nvim
export EDITOR=$VISUAL
export PAGER=less

export FILTHY_SHOW_EXIT_CODE=1

# enable colored output from ls, etc
export CLICOLOR=1

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_COMPLETION_TRIGGER=',,'
if [ -n "$TMUX" ]; then
  if [[ "$TMUX" != *"tmate"* ]]; then
    export FZF_DEFAULT_OPTS='--tmux 80%'
  fi
fi

export TIMEFMT=$'user\t%U\nsys\t%S\nreal\t%E\nmax mem\t%Mkb\ncpu\t%P\n'

# Per-machine settings (committed). Set any of the defaults below to override
# them, e.g. RSPEC_CORES on a smaller laptop.
[[ -f ~/.zsh/hosts/$DOTFILES_HOST.zsh ]] && source ~/.zsh/hosts/$DOTFILES_HOST.zsh

export DEV_DIR="${DEV_DIR:-$HOME/dev}"
export WORK_DIR="${WORK_DIR:-$DEV_DIR/prizepicks}"
export TEST_DATABASE_URL="postgresql://postgres:password@localhost/predict-picks-dev"
export RSPEC_CORES="${RSPEC_CORES:-12}"
export NODE_OPTIONS="--max-old-space-size=8192"
export COMPOSE_PROFILES="*"

[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
