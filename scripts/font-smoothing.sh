#!/usr/bin/env bash
set -e
set -x

defaults -currentHost write -globalDomain CGFontRenderingFontSmoothingDisabled -bool false
defaults -currentHost write -globalDomain AppleFontSmoothing -int 1
