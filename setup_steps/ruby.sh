# chruby is a shell function, so load it into this (bash) setup shell.
for chruby_sh in \
  /opt/homebrew/opt/chruby/share/chruby/chruby.sh \
  /usr/local/opt/chruby/share/chruby/chruby.sh \
  /home/linuxbrew/.linuxbrew/opt/chruby/share/chruby/chruby.sh \
  /usr/local/share/chruby/chruby.sh \
  /usr/share/chruby/chruby.sh; do
  [ -f "$chruby_sh" ] && . "$chruby_sh" && break
done

install_ruby() {
  if [ -d ~/.rubies/ruby-$1 ]; then
    echo "skipping install ruby $1: already installed"
  else
    ruby-install ruby-$1
    chruby $1
    gem install bundler
    gem install neovim
    gem install rubocop
    gem install ruby-lsp
    gem install ruby-lsp-rails
  fi
  echo ""
}

install_ruby "3.4.3"
