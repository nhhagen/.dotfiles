set runtimepath^=~/.vim runtimepath+=~/.vim/after

let &packpath = &runtimepath

let g:python_host_prog = '$HOME/.pyenv/versions/neovim2/bin/python'
let g:python2_host_prog = '$HOME/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '$HOME/.pyenv/versions/neovim3/bin/python'

source ~/.vimrc
