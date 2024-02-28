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
nmap <silent> <C-]> <Plug>(ale_go_to_definition)
nmap <silent> <C-W><C-]> <Plug>(ale_go_to_definition_in_tab)
nmap <silent> <C-k> <Plug>(ale_previous)
nmap <silent> <C-j> <Plug>(ale_next)

" noremap Y "+y
" nnoremap YY "+yy

" Enable code completion
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled = 1
set completeopt=menu,menuone,preview,noselect,noinsert
" Show symbol information in a popup window
" set completeopt=menu,menuone,popup,noselect,noinsert

" Set ALE linter settings
let g:ale_linters = {
	    \'rust': ['analyzer'],
	    \'go': ['gopls', 'staticcheck', 'gofmt', 'govet'],
	    \}
let g:ale_fixers = {
	    \'*': ['trim_whitespace', 'remove_trailing_lines'],
	    \'rust': ['rustfmt'],
	    \'go': ['goimports', 'gofmt']
	    \}

" Show virtual text column for current line only
let g:ale_virtualtext_cursor = 1
" Use virtual text styles from an older version
highlight link ALEVirtualTextError SpellBad
highlight link ALEVirtualTextWarning SpellCap

" Automatically fix (format) files on save
let g:ale_fix_on_save = 1
" Or disable/enable ALE conditionally?
" let g:ale_pattern_options= {'\.go$': {'ale_enabled': 0}}

" Go options
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" Rust options
autocmd BufNewFile,BufRead *.rs set filetype=rust
