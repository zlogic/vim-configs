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
nmap <silent> gd <Plug>(ale_go_to_definition)
nmap <silent> gD <Plug>(ale_go_to_declaration)
nmap <silent> <C-W>gd <Plug>(ale_go_to_definition_in_tab)
nmap <silent> gr :ALEFindReferences -quickfix <CR>
nmap <silent> [d <Plug>(ale_previous)
nmap <silent> ]d <Plug>(ale_next)
nmap <silent> K <Plug>(ale_hover)
nmap <silent> <space>ca <Plug>(ale_code_action)
nmap <silent> <space>rn <Plug>(ale_rename)

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

" Automatically fix (format) files on save
let g:ale_fix_on_save = 1
let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_on_text_changed = 'always'
" Or disable/enable ALE conditionally?
" let g:ale_pattern_options= {'\.go$': {'ale_enabled': 0}}

" Fix for https://github.com/dense-analysis/ale/issues/4642
" set ttimeoutlen=100
"augroup FastEscape
"    autocmd!
"    au InsertEnter * set timeoutlen=0
"    au InsertLeave * set timeoutlen=1000
"augroup END
inoremap <C-c> <Esc>

" Go options
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" Rust options
autocmd BufNewFile,BufRead *.rs set filetype=rust
