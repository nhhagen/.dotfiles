#!/usr/bin/env bash

git pull
git submodule update --init --recursive
git submodule foreach git pull origin master
git add -A .
git commit -m "Ran update.sh"
sh ~/.dotfiles/setup.sh
rm .vim/.vim

