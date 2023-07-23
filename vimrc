set number
set linebreak
set showmatch
 
set hlsearch
set smartcase
set ignorecase
set incsearch
 
set autoindent
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
 
set ruler

" Enable syntax highlighting
syntax enable

" Enable filetype plugins
filetype plugin indent on

" Shortcuts
imap <tab><tab> <c-x><c-o>

" Load configs
runtime go.vim
runtime rust.vim

