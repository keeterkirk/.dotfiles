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

if [ -d "/home/linuxbrew" ]; then
  source /home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.zsh
  source /home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.zsh
elif [ -d "/usr/share/doc/fzf/examples" ]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
else
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

opentmux

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.local/bin:$PATH"

# Android SDK
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Google Cloud credentials for voice-to-text
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/speech-to-text-key.json"

# Source secrets (API tokens, etc.) from outside the repo
[[ -f ~/.secrets ]] && source ~/.secrets

# Android Studio & JDK 17 for React Native
export ANDROID_STUDIO_HOME="$HOME/opt/android-studio"
export JAVA_HOME="$HOME/opt/jdk/jdk-17.0.14+7"
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$ANDROID_STUDIO_HOME/bin:$JAVA_HOME/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export LIBGL_DRIVERS_PATH="/usr/lib/x86_64-linux-gnu/dri"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
