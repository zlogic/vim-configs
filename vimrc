set number
set linebreak
set showbreak=+++
set textwidth=100
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
syntax on

" Enable filetype plugins
filetype plugin on

" Shortcuts
imap <tab><tab> <c-x><c-o>

" Load configs
runtime go.vim
