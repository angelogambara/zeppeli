#!/bin/zsh

# ###########
# Android
# ###########

export ANDROID_EMULATOR_HOME="$XDG_DATA_HOME"/android
export ANDROID_HOME="$XDG_DATA_HOME"/android
export ANDROID_SDK_ROOT="$XDG_DATA_HOME"/android/sdk

# ###########
# Java
# ###########

export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CACHE_HOME"/java
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

# ###########
# Node/NPM
# ###########

export NODE_REPL_HISTORY="$XDG_STATE_HOME"/node/history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

# ###########
# Python
# ###########

export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME"/python
export PYTHONUSERBASE="$XDG_DATA_HOME"/python
export PYTHON_HISTORY="$XDG_STATE_HOME"/python/history

# ###########
# Rust
# ###########

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

# ###########
# X11
# ###########

export XAUTHORITY="$XDG_CACHE_HOME"/Xauthority
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
