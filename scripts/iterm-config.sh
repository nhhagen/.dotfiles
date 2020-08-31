#!/usr/bin/env bash
set -e
set -x

defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -int 1
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "${HOME}/.iterm"
