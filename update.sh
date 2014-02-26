#!/usr/bin/env bash

git pull --rebase
git submodule update --init --recursive
git submodule foreach git pull origin master
git add -A .
git commit -m "Ran update.sh"
git push
sh ~/.dotfiles/setup.sh

