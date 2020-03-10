#!/usr/bin/env bash
set -e
set -x

defaults write com.apple.systemuiserver menuExtras '
(
    "/System/Library/CoreServices/Menu Extras/AirPort.menu",
    "/System/Library/CoreServices/Menu Extras/Battery.menu",
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu",
    "/System/Library/CoreServices/Menu Extras/Clock.menu",
    "/System/Library/CoreServices/Menu Extras/Displays.menu",
    "/System/Library/CoreServices/Menu Extras/Volume.menu"
)'

killall SystemUIServer
