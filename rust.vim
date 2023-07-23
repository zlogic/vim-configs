" Automatically detect Rust files
autocmd BufNewFile,BufRead *.rs set filetype=rust
" Enable code completion
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled = 1
set completeopt=menu,menuone,preview,noselect,noinsert
" Set ALE linter settings
let g:ale_linters = {
\  'rust': ['analyzer'],
\}
let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }
" Format in save
let g:rustfmt_autosave = 1

