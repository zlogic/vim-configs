set noerrorbells
set visualbell

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

" Enable lsp plugin
packadd vim-lsp

" Enable filetype plugins
filetype plugin indent on

" Command autocompletion
set wildmenu
set wildmode=longest:full,full

" Shortcuts
" noremap Y "+y
" nnoremap YY "+yy

" Show autocomplete description in preview pane
set completeopt=menu,menuone,preview,noselect,noinsert
" Show symbol information in a popup window
" set completeopt=menu,menuone,popup,noselect,noinsert
" set completepopup=align:menu,border:off

" Set LSP settings
let g:lsp_use_native_client = 1
let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_document_symbol_detail = 1
" let g:lsp_diagnostics_virtual_text_prefix = " ‣ "
" The default diagVirtualTextAlign: 'above' option needs
" a fix from https://github.com/vim/vim/issues/14049
" (or just a newer Vim version?)
" Also, aligning below seems to offset the cursor line...

function! s:on_lsp_buffer_attached() abort
    " Shortcuts
    "nmap <silent> <C-]> <Cmd>LspGotoDefinition<CR>
    "nmap <silent> <C-W><C-]> :tab LspGotoDefinition<CR>
    nnoremap <buffer> gd <plug>(lsp-definition)
    nnoremap <buffer> gD <plug>(lsp-declaration)
    nnoremap <buffer> <C-W>gd :tab LspDefinition<CR>
    nnoremap <buffer> gi <plug>(lsp-implementation)
    nnoremap <buffer> gr <plug>(lsp-references)
    "nnoremap <buffer> <space>pr <Cmd>LspPeekReferences<CR>
    nnoremap <buffer> [d <plug>(lsp-previous-diagnostic)
    nnoremap <buffer> ]d <plug>(lsp-next-diagnostic)
    nnoremap <buffer> <space>ca <plug>(lsp-code-action)
    nnoremap <buffer> <space>rn <plug>(lsp-rename)
    "nnoremap <buffer> <space>e <Cmd>LspDiagCurrent<CR>
    nnoremap <buffer> <space>q <plug>(lsp-document-diagnostics)

    " Enable hover on K
    set keywordprg=:LspHover
    " Go to definition with LSP
    setlocal tagfunc=lsp#tagfunc
    " Set default formatter on gq
    " setlocal formatexpr=lsp#lsp#FormatExpr()
    " Format on save
    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " Close preview window after completion
    au CompleteDone * pclose
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_attached()
augroup END

" Go options
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" Rust options
autocmd BufNewFile,BufRead *.rs set filetype=rust
