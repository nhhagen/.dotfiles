#!/usr/bin/env bash

SYSTEM_TYPE=$(uname)

LINUX='Linux'
OSX='Darwin'
ln -Ffs ~/.dotfiles/.gitconfig ~/.gitconfig
ln -fs ~/.dotfiles/.vimrc ~/.vimrc
ln -fs ~/.dotfiles/.vim ~/.vim && rm -f ~/.dotfiles/.vim/.vim
ln -fs ~/.dotfiles/.bash_prompt ~/.bash_prompt
ln -fs ~/.dotfiles/.tmux.conf ~/.tmux.conf
if [ "$SYSTEM_TYPE" == "$LINUX" ]; then
  ln -Ffs ~/.dotfiles/.bashrc_linux ~/.bashrc
fi
if [ "$SYSTEM_TYPE" == "$OSX" ]; then
  ln -Ffs ~/.dotfiles/.bashrc_mac ~/.bashrc
  ln -Ffs ~/.dotfiles/.bash_profile_mac ~/.bash_profile

  ROOT=$(pwd)
  cd ~/.dotfiles/.vim/bundle/YouCompleteMe/
  ./install.sh

  cd ~/.dotfiles/.vim/bundle/tern_for_vim
  npm install

  cd $ROOT
fi

