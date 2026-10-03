export VISUAL=nvim
export EDITOR=$VISUAL
export PAGER=less
export LC_CTYPE=en_US.UTF-8

# Homebrew (macOS). Must run here rather than .zshenv: macOS's /etc/zprofile
# runs path_helper, which reorders anything .zshenv put on PATH.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

typeset -U path
path=(~/bin ~/opt/bin ~/go/bin $path)

if [[ $DOTFILES_OS == darwin ]]; then
  # keg-only node from Homebrew, and Docker Desktop's CLI tools
  [[ -d $HOMEBREW_PREFIX/opt/node@22/bin ]] && path=($HOMEBREW_PREFIX/opt/node@22/bin $path)
  [[ -d ~/.docker/bin ]] && path+=(~/.docker/bin)
fi

[[ -f ~/.zprofile.local ]] && source ~/.zprofile.local

if [ -d "/home/linuxbrew" ]; then
  source /home/linuxbrew/.linuxbrew/opt/chruby/share/chruby/chruby.sh
elif [[ -n $HOMEBREW_PREFIX && -f $HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh ]]; then
  source $HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh
elif [ -f "/usr/local/share/chruby/chruby.sh" ]; then
  source /usr/local/share/chruby/chruby.sh
elif [ -f "/usr/share/chruby/chruby.sh" ]; then
  source /usr/share/chruby/chruby.sh
fi

command -v chruby > /dev/null && chruby ruby-3.4.3

[ -f ~/.zsh/functions/chruby_auto.sh ] && source ~/.zsh/functions/chruby_auto.sh
