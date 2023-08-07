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

" Command autocompletion
set wildmenu
set wildmode=longest:full,full

" Shortcuts
" imap <tab><tab> <c-x><c-o>
nmap <silent> <c-]> <Plug>(ale_go_to_definition)
nmap <silent> <C-k> <Plug>(ale_previous)
nmap <silent> <C-j> <Plug>(ale_next)

" Enable code completion
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled = 1
set completeopt=menu,menuone,preview,noselect,noinsert
" Show symbol information in a popup window
" set completeopt=menu,menuone,popup,noselect,noinsert

" Set ALE linter settings
let g:ale_linters = {
	    \'rust': ['analyzer'],
	    \'go': ['gopls', 'golangci-lint', 'gofmt'],
	    \}
let g:ale_fixers = {
	    \'*': ['trim_whitespace', 'remove_trailing_lines'],
	    \'rust': ['rustfmt'],
	    \'go': ['goimports', 'gofmt']
	    \}

" Disable confusing autocomments
let g:ale_virtualtext_cursor = 'auto'

" Go options
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" Rust options
autocmd BufNewFile,BufRead *.rs set filetype=rust
let g:rustfmt_autosave = 1

