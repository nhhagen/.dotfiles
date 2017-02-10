#!/usr/bin/env bash

SYSTEM_TYPE=$(uname)

LINUX='Linux'
OSX='Darwin'

mkdir -p ~/.subversion
mkdir -p ~/bin

ln -Ffs ~/.dotfiles/alias.sh ~/.alias
ln -Ffs ~/.dotfiles/.gitconfig ~/.gitconfig
ln -Ffs ~/.dotfiles/.bash_prompt ~/.bash_prompt


if [ "$SYSTEM_TYPE" == "$OSX" ]; then
    brew tap Goles/battery
    brew update && brew upgrade --all
    packages=(
        cmake
        zsh
        zsh-completions
        zsh-syntax-highlighting
        vim
        tmux
        git
        git-flow-avh
        node
        ack
        reattach-to-user-namespace
        wget
        the_silver_searcher
        battery
    )
    for package in ${packages[*]}; do
        brew install $package
    done

    gems=(
        tmuxinator
    )
    for gem in ${gems[*]}; do
        sudo gem install $gem
    done

    ln -Ffs ~/.dotfiles/.ackrc ~/.ackrc
    ln -Ffs ~/.dotfiles/.alias ~/.alias
    ln -Ffs ~/.dotfiles/.bash_profile_mac ~/.bash_profile
    ln -Ffs ~/.dotfiles/.bash_prompt ~/.bash_prompt
    ln -Ffs ~/.dotfiles/.bashrc_mac ~/.bashrc
    ln -Ffs ~/.dotfiles/.colordiffrc ~/.colordiffrc
    ln -Ffs ~/.dotfiles/.colorsvnrc ~/.colorsvnrc
    ln -Ffs ~/.dotfiles/.gitconfig ~/.gitconfig
    ln -Ffs ~/.dotfiles/.subversion/config ~/.subversion/config
    ln -Ffs ~/.dotfiles/.subversion/merge.sh ~/.subversion/merge.sh
    ln -Ffs ~/.dotfiles/.tmux.conf ~/.tmux.conf
    ln -Ffs ~/.dotfiles/.vim ~/.vim && rm -f ~/.dotfiles/.vim/.vim
    ln -Ffs ~/.dotfiles/.vimrc ~/.vimrc
    ln -Ffs ~/.dotfiles/.zsh ~/.zsh && rm -f ~/.dotfiles/.zsh/.zsh
    ln -Ffs ~/.dotfiles/.zsh_prompt ~/.zsh_prompt
    ln -Ffs ~/.dotfiles/.zshrc ~/.zshrc
    ln -Ffs ~/.dotfiles/alias.sh ~/.alias
    ln -Ffs ~/.dotfiles/eslintrc ~/.eslintrc
    ln -Ffs ~/.dotfiles/ctags ~/.ctags
    ln -Ffs ~/.dotfiles/agignore ~/.agignore

    ln -Ffs ~/.dotfiles/bin/cpu.sh ~/bin/cpu.sh
    ln -Ffs ~/.dotfiles/bin/git-livelog ~/bin/git-livelog
    ln -Ffs ~/.dotfiles/bin/git-sync ~/bin/git-sync
    ln -Ffs ~/.dotfiles/bin/helpers.sh ~/bin/helpers.sh
    ln -Ffs ~/.dotfiles/bin/wifi.sh ~/bin/wifi.sh

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

