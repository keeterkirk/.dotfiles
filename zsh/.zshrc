unsetopt nomatch
setopt extendedglob

# completion
fpath=(~/.zsh/filthy $fpath)

# completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''

# load custom functions
for function in ~/.zsh/functions/*; do
  source $function
done

if type "dircolors" > /dev/null; then
  eval `dircolors ~/.zsh/dircolors.ansi-dark`
fi

# syntax highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# history settings
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000
setopt share_history
setopt inc_append_history
setopt extended_history

# vi mode
bindkey -v
bindkey "^R" history-incremental-search-backward

# provide zmv command for easy bulk renaming
# example for changing extension of all matching files in a heirarchy:
# zmv '(**/)(*).css.scss' '$1/$2.scss'
autoload -U zmv

# prompt
autoload -U promptinit && promptinit
prompt filthy

[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# fzf >= 0.48 ships its own zsh integration; older distro packages
# (e.g. Ubuntu's) only install the scripts.
if fzf --zsh > /dev/null 2>&1; then
  source <(fzf --zsh)
elif [ -d "/home/linuxbrew" ]; then
  source /home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.zsh
  source /home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.zsh
elif [ -d "/usr/share/doc/fzf/examples" ]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
elif [ -f "/usr/share/fzf/key-bindings.zsh" ]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# Only prompt for tmux in a real terminal (not editor/agent/script shells).
[[ -t 0 && -t 1 ]] && opentmux

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.local/bin:$PATH"

# OS-specific interactive config (~/.zsh/os/linux.zsh, ~/.zsh/os/darwin.zsh)
[[ -f ~/.zsh/os/$DOTFILES_OS.zsh ]] && source ~/.zsh/os/$DOTFILES_OS.zsh

# Source secrets (API tokens, etc.) from outside the repo
[[ -f ~/.secrets ]] && source ~/.secrets

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
