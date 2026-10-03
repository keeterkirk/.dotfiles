# Sourced from .zshrc on macOS only.

# GNU dircolors comes from Homebrew coreutils as gdircolors; BSD ls ignores
# LS_COLORS, but zsh completion (list-colors) and fd/eza use it.
if type "gdircolors" > /dev/null; then
  eval `gdircolors ~/.zsh/dircolors.ansi-dark`
fi

# Android SDK (installed by Android Studio)
if [[ -d ~/Library/Android/sdk ]]; then
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools
fi
