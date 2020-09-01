#!/usr/bin/env bash
set -e
set -x

defaults write com.apple.dock static-only -bool TRUE
defaults write com.apple.dock showhidden -bool TRUE
defaults write com.apple.dock tilesize -integer 32
defaults write com.apple.dock autohide -integer 1

killall Dock
