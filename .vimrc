" Source the vimrc file after saving it
if has("autocmd")
  autocmd! bufwritepost .vimrc source $MYVIMRC
endif

execute pathogen#infect()
execute pathogen#helptags()

set nobackup
set nowritebackup
set nocompatible                " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
set number
set relativenumber
set ruler
set scrolloff=2                   " minimum lines above/below cursor
set laststatus=2                  " always show status bar

set background=dark
colorscheme monokai
"let g:molokai_original = 1
let g:rehash256 = 1

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

