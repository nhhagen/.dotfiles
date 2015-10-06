#!/usr/bin/env bash

SYSTEM_TYPE=$(uname)

LINUX='Linux'
OSX='Darwin'

ln -fs ~/.dotfiles/alias.sh ~/.alias
ln -Ffs ~/.dotfiles/.gitconfig ~/.gitconfig
ln -fs ~/.dotfiles/.bash_prompt ~/.bash_prompt
ln -fs ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -fs ~/.dotfiles/.ackrc ~/.ackrc
mkdir -p ~/.subversion
ln -fs ~/.dotfiles/.subversion/config ~/.subversion/config
ln -fs ~/.dotfiles/.subversion/merge.sh ~/.subversion/merge.sh
ln -fs ~/.dotfiles/.colordiffrc ~/.colordiffrc
ln -fs ~/.dotfiles/.colorsvnrc ~/.colorsvnrc
ln -fs ~/.dotfiles/eslintrc ~/.eslintrc


if [ "$SYSTEM_TYPE" == "$OSX" ]; then
    packages=(
        zsh
        zsh-completions
        zsh-syntax-highlighting
        vim
        tmux
        git
        git-flow
        node
        ack
        reattach-to-user-namespace
        wget
        the_silver_searcher
    )
    for package in ${packages[*]}; do
        brew install $package
    done

    ln -fs ~/.dotfiles/.vimrc ~/.vimrc
    ln -fs ~/.dotfiles/.vim ~/.vim && rm -f ~/.dotfiles/.vim/.vim
    ln -Ffs ~/.dotfiles/.bashrc_mac ~/.bashrc
    ln -Ffs ~/.dotfiles/.bash_profile_mac ~/.bash_profile
    ln -Ffs ~/.dotfiles/.zshrc ~/.zshrc
    ln -Ffs ~/.dotfiles/.zsh_prompt ~/.zsh_prompt

    vim +qall
    ROOT=$(pwd)
    cd ~/.dotfiles/.vim/bundle/YouCompleteMe/
    ./install.sh --clang-completer

    cd ~/.dotfiles/.vim/bundle/tern_for_vim
    npm install

    cd $ROOT
fi

if [ "$SYSTEM_TYPE" == "$LINUX" ]; then
    ln -Ffs ~/.dotfiles/.bashrc_linux ~/.bashrc
fi

