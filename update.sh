#!/usr/bin/env bash

git pull --rebase
git submodule update --init --recursive
git submodule foreach git pull origin master
git add -A .
git commit -m "Ran update.sh"
git push
>>>>>>> parent of a208583... failing update early
sh ~/.dotfiles/setup.sh
rm .vim/.vim

