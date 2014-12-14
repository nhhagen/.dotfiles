" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:
" vim: set tabstop=2 shiftwidth=2:

" No legacy vi, must be first {
  set nocompatible
" }

" Source the vimrc file after saving it {
  if has("autocmd")
    autocmd! bufwritepost .vimrc source $MYVIMRC | AirlineRefresh
  endif
" }

" Plugin management {
  filetype off

  " Vundle install {
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
    Plugin 'gmarik/vundle'
  " }

  " General {
    Plugin 'bling/vim-airline'
    Plugin 'airblade/vim-gitgutter.git'
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
    Plugin 'edkolev/tmuxline.vim'
    Plugin 'luochen1990/rainbow'
    Plugin 'sickill/vim-monokai.git'
    Plugin 'tomasr/molokai.git'
    Plugin 'kien/ctrlp.vim.git'
    Plugin 'tpope/vim-fugitive.git'
    Plugin 'rking/ag.vim'
    Plugin 'sjl/vitality.vim'
    Plugin 'editorconfig/editorconfig-vim.git'
    Plugin 'Raimondi/delimitMate.git'
    Plugin 'mattn/gist-vim.git'
    Plugin 'greyblake/vim-preview'
    Plugin 'mtth/scratch.vim'
  " }

  " Completion {
    Plugin 'Valloric/YouCompleteMe.git'
    Plugin 'marijnh/tern_for_vim.git'
  " }

  " JavaScript {
    Plugin 'moll/vim-node.git'
    Plugin 'jelera/vim-javascript-syntax.git'
    Plugin 'vim-scripts/JavaScript-Indent.git'
    Plugin 'pangloss/vim-javascript'
    Plugin 'mxw/vim-jsx'
  " }

  " Ruby {
    Plugin 'vim-ruby/vim-ruby'
    Plugin 'tpope/vim-bundler'
    Plugin 'tpope/vim-endwise'
  " }

  " Python {
    " Plugin 'hdima/python-syntax'
    Plugin 'klen/python-mode'
  "}

  " Misc language & syntax support {
    Plugin 'scrooloose/syntastic.git'
    Plugin 'PProvost/vim-ps1.git'
    Plugin 'othree/html5.vim'
    Plugin 'godlygeek/tabular'
    Plugin 'plasticboy/vim-markdown'
    Plugin 'rodjek/vim-puppet.git'
    Plugin 'saltstack/salt-vim.git'
    Plugin 'evanmiller/nginx-vim-syntax.git'
    Plugin 'derekwyatt/vim-scala'
    Plugin 'gre/play2vim.git'
  " }

  "Plugin 'mattn/webapi-vim.git'
  "Plugin 'xolox/vim-misc'
  "Plugin 'xolox/vim-easytags'

  " Vundle install {
    if iCanHazVundle == 0
      echo 'Installing Plugins, please ignore key map error messages'
      echo ''
      :PluginInstall
    endif
  " }
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
  set wildmenu            " visual autocomplete for command menu"
  set noshowmode

  nmap <C-c> :set invnumber invrelativenumber<CR>
" }

" Colors & UI {
  set t_Co=256
  set t_ut=
  colorscheme Tomorrow-Night
  let &colorcolumn="81,".join(range(121,999),",")
  " autocmd BufEnter * if &diff | set cursorline! | else | set cursorline | endif
  set cursorline
  highlight SignColumn ctermbg=none
  " highlight Comment cterm=italic
  " highlight Folded cterm=italic
  " highlight javaMethodTag ctermfg=222 guifg=#f0c674
  set fillchars+=vert:│ " must have whitespace after the |
  autocmd BufEnter * sign define dummy
  autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
" }

" Folding {
  set foldmethod=indent   " fold based on indent
  set foldnestmax=3       " deepest fold is 3 levels
  set foldlevel=100       " don't autofold anything (but let me do it if I want to)
" }

" Whitespace {
  set nowrap                      " don't wrap lines
  set tabstop=4 shiftwidth=4      " a tab is 4 spaces
  set smarttab                    " insert tabs on the start of a line according to shiftwidth, not tabstop
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
  " nmap <C-w> :bd<CR> need to find a new key
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
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*.log,*/target/*,*/tags/*
  set wildignore+=*/node_modules/*
  set wildignore+=*/bower_components/*
  set wildignore+=*/analyze/*
  set wildignore+=*/.git/*
  set wildignore+=*/.svn/*
  set wildignore+=*/.idea/*,*/.idea_modules/*
  set wildignore+=*/.vagrant/*
  set wildignore+=*/.target/*
  set wildignore+=*.pyc
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

" System clipboard support {
  set clipboard=unnamed
" }

" Rainbow Parentheses {
  let g:rainbow_active = 1
  let g:rainbow_conf = { 'parentheses': [['(',')'], ['\[','\]'], ['{','}']], 'html': { 'parentheses': [] } }
" }

" eclim {
  if exists('EclimEnable')
    autocmd BufEnter * EclimDisable
    autocmd BufEnter *.java EclimEnable
  endif
" }

" ctrlp {
  let g:ctrlp_show_hidden = 1
  let g:ctrlp_extensions = ['tag']
" }

" vim-indent-guides {
  let g:indent_guides_auto_colors = 0
  let g:indent_guides_guide_size = 1
  let g:indent_guides_start_level = 2
  highlight IndentGuidesOdd  ctermbg=236 guibg=#3a3a3a
  highlight IndentGuidesEven ctermbg=236 guibg=#3a3a3a
  au VimEnter * :IndentGuidesEnable
" }

" Ag {
  let g:aghighlight = 1
" }

" Systastic {
  let g:syntastic_javascript_checkers = ['jsxhint']
" }

" Scratch {
  let g:scratch_insert_autohide = 0
"}
