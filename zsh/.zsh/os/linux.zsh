# Sourced from .zshrc on Linux only.

# Android SDK
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Google Cloud credentials for voice-to-text
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/speech-to-text-key.json"

# Android Studio & JDK 17 for React Native
export ANDROID_STUDIO_HOME="$HOME/opt/android-studio"
export JAVA_HOME="$HOME/opt/jdk/jdk-17.0.14+7"
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$ANDROID_STUDIO_HOME/bin:$JAVA_HOME/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export LIBGL_DRIVERS_PATH="/usr/lib/x86_64-linux-gnu/dri"
