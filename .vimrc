" vim: set foldmarker={,} foldlevel=0 foldmethod=marker :

" No legacy vi, must be first {
  set nocompatible
" }

" Source the vimrc file after saving it {
  if has("autocmd")
    autocmd! bufwritepost .vimrc source $MYVIMRC
  endif
" }

" Vundle {
  filetype off

  let iCanHazVundle=1
  let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
  if !filereadable(vundle_readme)
    echo 'Installing Vundle..'
    echo ''
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
  endif
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()
  Bundle 'gmarik/vundle'
  Bundle 'vim-scripts/JavaScript-Indent.git'
  Bundle 'Valloric/YouCompleteMe.git'
  Bundle 'kien/ctrlp.vim.git'
  Bundle 'Raimondi/delimitMate.git'
  Bundle 'editorconfig/editorconfig-vim.git'
  Bundle 'mattn/gist-vim.git'
  Bundle 'tomasr/molokai.git'
  Bundle 'evanmiller/nginx-vim-syntax.git'
  Bundle 'moll/vim-node.git'
  Bundle 'rodjek/vim-puppet.git'
  Bundle 'saltstack/salt-vim.git'
  Bundle 'scrooloose/syntastic.git'
  Bundle 'marijnh/tern_for_vim.git'
  Bundle 'bling/vim-airline'
  Bundle 'tpope/vim-fugitive.git'
  Bundle 'airblade/vim-gitgutter.git'
  Bundle 'jelera/vim-javascript-syntax.git'
  Bundle 'sickill/vim-monokai.git'
  Bundle 'PProvost/vim-ps1.git'
  Bundle 'mattn/webapi-vim.git'
  Bundle 'gre/play2vim.git'
  Bundle 'derekwyatt/vim-scala'
  Bundle 'othree/html5.vim'
  Bundle 'plasticboy/vim-markdown'

  if iCanHazVundle == 0
    echo 'Installing Bundles, please ignore key map error messages'
    echo ''
    :BundleInstall
  endif
" }

" Basics {
  filetype plugin indent on       " load file type plugins + indentation
  set t_Co=256
  set title
  set noswapfile
  set nobackup
  set nowritebackup
  syntax enable
  set encoding=utf-8
  set showcmd                     " display incomplete commands
  set number
  set relativenumber
  set ruler
  set scrolloff=9                   " minimum lines above/below cursor
  set laststatus=2                  " always show status bar
  set autoread
  set autowrite
  set hidden
" }

" Colors & UI {
  colorscheme smyck
  ""let g:rehash256 = 1
  ""let g:molokai_original = 1
  ""colorscheme molokai
  let &colorcolumn="81,".join(range(121,999),",")
  highlight ColorColumn ctermbg=235 guibg=#2c2d27
  set cursorline
  highlight CursorLine ctermbg=235 guibg=#2c2d27
  highlight SignColumn ctermbg=235 guibg=#2c2d27
  highlight Folded ctermbg=235 guibg=#2c2d27 ctermfg=8 guifg=#8F8F8F
  highlight VertSplit ctermbg=10 guibg=#d1fa71 ctermfg=235 guifg=#2c2d27
  set fillchars+=vert:│ " must have whitespace after the \
  autocmd BufEnter * sign define dummy
  autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
" }

" Folding {
  set foldmethod=indent   "fold based on indent
  set foldnestmax=3       "deepest fold is 3 levels
  "set nofoldenable        "dont fold by default
  set foldlevel=100       " don't autofold anything (but let me do it if I want to)
" }

" Whitespace {
  set nowrap                      " don't wrap lines
  set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
  set expandtab                   " use spaces, not tabs (optional)
  set backspace=indent,eol,start  " backspace through everything in insert mode
" }

" Searching {
  set hlsearch                    " highlight matches
  set incsearch                   " incremental searching
  set ignorecase                  " searches are case insensitive...
  set smartcase                   " ... unless they contain at least one capital letter
" }

" Buffer management {
  nmap <C-h> :bp<CR>
  nmap <C-l> :bn<CR>
" }

" Delimate {
  let delimitMate_expand_cr = 1
" }

" Airline {
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
" }

" YouCompleteMe {
  let g:ycm_add_preview_to_completeopt = 1
  let g:ycm_autoclose_preview_window_after_completion = 1
  let g:ycm_collect_identifiers_from_comments_and_strings = 1
  let g:ycm_collect_identifiers_from_tags_files = 1
  let g:ycm_seed_identifiers_with_syntax = 1
  let g:ycm_complete_in_comments = 1
" }

" Ignores {
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*/target/*
  set wildignore+=*/node_modules/*,*/bower_components/*
" }

" Resize splits when the window is resized {
  au VimResized * exe "normal! \<c-w>="
" }

" Reselect visual block after indent/outdent {
  vnoremap < <gv
  vnoremap > >gv
" }

" Turn off normal arrow keys for navigation {
  noremap <Up> <nop>
  noremap <Down> <nop>
  noremap <Left> <nop>
  noremap <Right> <nop>
  inoremap  <Up> <NOP>
  inoremap  <Down> <NOP>
  inoremap  <Left> <NOP>
  inoremap  <Right> <NOP>
" }
