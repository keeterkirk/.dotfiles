export DOTFILES=$HOME/.dotfiles
export PATH="$DOTFILES/bin:$PATH"

export VISUAL=nvim
export EDITOR=$VISUAL
export PAGER=less

export FILTHY_SHOW_EXIT_CODE=1

# enable colored output from ls, etc
export CLICOLOR=1

export FZF_DEFAULT_COMMAND='ag -g "" --hidden --ignore .git'
export FZF_COMPLETION_TRIGGER=',,'
if [ -n "$TMUX" ]; then
  export FZF_DEFAULT_OPTS='--tmux 80%'
fi

export TIMEFMT=$'user\t%U\nsys\t%S\nreal\t%E\nmax mem\t%Mkb\ncpu\t%P\n'

[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
