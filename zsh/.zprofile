export VISUAL=nvim
export EDITOR=$VISUAL
export PAGER=less
export LC_CTYPE=en_US.UTF-8

typeset -U path
path=(~/.dotfiles/bin ~/opt/bin ~/go/bin $path)

[[ -f ~/.zprofile.local ]] && source ~/.zprofile.local

if [ -d "/home/linuxbrew" ]; then
  source /home/linuxbrew/.linuxbrew/opt/chruby/share/chruby/chruby.sh
elif [ -f "/usr/local/share/chruby/chruby.sh" ]; then
  source /usr/local/share/chruby/chruby.sh
elif [ -f "/usr/share/chruby/chruby.sh" ]; then
  source /usr/share/chruby/chruby.sh
fi

command -v chruby > /dev/null && chruby ruby-3.4.3

[ -f ~/.zsh/functions/chruby_auto.sh ] && source ~/.zsh/functions/chruby_auto.sh
