#!/usr/bin/env bash

SYSTEM_TYPE=$(uname)

LINUX='Linux'
OSX='Darwin'

if [ "$SYSTEM_TYPE" == "$OSX" ]; then
    packages=(
        vim
        tmux
        git
        git-flow
        node
        ack
        reattach-to-user-namespace
        wget
    )
    for package in ${packages[*]}; do
        brew install $package
    done
fi
exit
ln -Ffs ~/.dotfiles/.gitconfig ~/.gitconfig
ln -fs ~/.dotfiles/.vimrc ~/.vimrc
ln -fs ~/.dotfiles/.vim ~/.vim && rm -f ~/.dotfiles/.vim/.vim
ln -fs ~/.dotfiles/.bash_prompt ~/.bash_prompt
ln -fs ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -fs ~/.dotfiles/.ackrc ~/.ackrc
mkdir ~/.subversion
ln -fs ~/.dotfiles/.subversion/config ~/.subversion/config
ln -fs ~/.dotfiles/.subversion/merge.sh ~/.subversion/merge.sh
ln -fs ~/.dotfiles/.colordiffrc ~/.colordiffrc
ln -fs ~/.dotfiles/.colorsvnrc ~/.colorsvnrc

#vim +PluginUpdate +qall

if [ "$SYSTEM_TYPE" == "$LINUX" ]; then
    ln -Ffs ~/.dotfiles/.bashrc_linux ~/.bashrc
fi
if [ "$SYSTEM_TYPE" == "$OSX" ]; then
    ln -Ffs ~/.dotfiles/.bashrc_mac ~/.bashrc
    ln -Ffs ~/.dotfiles/.bash_profile_mac ~/.bash_profile
    ln -Ffs ~/.dotfiles/.zshrc ~/.zshrc
    ln -Ffs ~/.dotfiles/.zsh_prompt ~/.zsh_prompt

    ROOT=$(pwd)
    cd ~/.dotfiles/.vim/bundle/YouCompleteMe/
    ./install.sh --clang-completer

    cd ~/.dotfiles/.vim/bundle/tern_for_vim
    npm install

    cd $ROOT
fi

