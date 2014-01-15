#!/usr/bin/env bash

git pull
git submodule update --init --recursive
git submodule foreach git pull origin master
git submodule update --init --recursive
sh ~/.dotfiles/setup.sh
