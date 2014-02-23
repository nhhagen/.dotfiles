set nocompatible                " choose no compatibility with legacy vi

" Source the vimrc file after saving it
if has("autocmd")
  autocmd! bufwritepost .vimrc source $MYVIMRC
endif

execute pathogen#infect()
execute pathogen#helptags()

set t_Co=256
set title
set noswapfile
set nobackup
set nowritebackup
syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
set number
set relativenumber
set ruler
set scrolloff=5                   " minimum lines above/below cursor
set laststatus=2                  " always show status bar
set autoread
set hidden

"" Folding
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default"

set background=dark
colorscheme smyck

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

let &colorcolumn="81,".join(range(121,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

" Buffer management
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>

let delimitMate_expand_cr = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
