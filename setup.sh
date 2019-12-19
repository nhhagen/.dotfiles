#!/usr/bin/env bash

SYSTEM_TYPE=$(uname)

LINUX='Linux'
OSX='Darwin'

mkdir -p ~/.subversion
mkdir -p ~/bin
mkdir -p ~/scripts

ln -Ffs ~/.dotfiles/alias ~/.alias
ln -Ffs ~/.dotfiles/gitconfig ~/.gitconfig
ln -Ffs ~/.dotfiles/bash_prompt ~/.bash_prompt
ln -Ffs ~/.dotfiles/scripts ~/scripts && rm -rf ~/.dotfiles/scripts/scripts

if [ "$SYSTEM_TYPE" == "$OSX" ]; then
    brew tap Goles/battery
    brew update && brew upgrade --all
    brew install \
        ack\
        battery\
        cmake\
        docker\
        docker-machine\
        git\
        git-flow-avh\
        git-standup\
        gpg\
        node\
        pyenv\
        pyenv-virtualenv\
        reattach-to-user-namespace\
        spark\
        the_silver_searcher\
        tig\
        tmux\
        tree\
        vim\
        wget\
        zsh\
        zsh-completions\
        zsh-syntax-highlighting

    gems=(
        tmuxinator
    )
    for gem in ${gems[*]}; do
        sudo gem install $gem
    done

    ln -Ffs ~/.dotfiles/ackrc ~/.ackrc
    ln -Ffs ~/.dotfiles/agignore ~/.agignore
    ln -Ffs ~/.dotfiles/bash_profile_mac ~/.bash_profile
    ln -Ffs ~/.dotfiles/bash_prompt ~/.bash_prompt
    ln -Ffs ~/.dotfiles/bashrc_mac ~/.bashrc
    ln -Ffs ~/.dotfiles/colordiffrc ~/.colordiffrc
    ln -Ffs ~/.dotfiles/colorsvnrc ~/.colorsvnrc
    ln -Ffs ~/.dotfiles/ctags ~/.ctags
    ln -Ffs ~/.dotfiles/editorconfig ~/.editorconfig
    ln -Ffs ~/.dotfiles/eslintrc ~/.eslintrc
    ln -Ffs ~/.dotfiles/gitconfig ~/.gitconfig
    ln -Ffs ~/.dotfiles/gitignore_global ~/.gitignore_global
    ln -Ffs ~/.dotfiles/subversion/config ~/.subversion/config
    ln -Ffs ~/.dotfiles/subversion/merge.sh ~/.subversion/merge.sh
    ln -Ffs ~/.dotfiles/tigrc ~/.tigrc
    ln -Ffs ~/.dotfiles/tmux.conf ~/.tmux.conf
    ln -Ffs ~/.dotfiles/vim ~/.vim && rm -f ~/.dotfiles/vim/vim
    ln -Ffs ~/.dotfiles/vimrc ~/.vimrc
    ln -Ffs ~/.dotfiles/zsh ~/.zsh && rm -f ~/.dotfiles/zsh/zsh
    ln -Ffs ~/.dotfiles/zsh_prompt ~/.zsh_prompt
    ln -Ffs ~/.dotfiles/zshrc ~/.zshrc

    cd $ROOT
fi

if [ "$SYSTEM_TYPE" == "$LINUX" ]; then
    ln -Ffs ~/.dotfiles/.bashrc_linux ~/.bashrc
fi

