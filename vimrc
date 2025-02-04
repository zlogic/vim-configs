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
packadd lsp

" Enable filetype plugins
filetype plugin indent on

" Command autocompletion
set wildmenu
set wildmode=longest:full,full

" Shortcuts
" noremap Y "+y
" nnoremap YY "+yy

" Show autocomplete description in preview pane
" set completeopt=menu,menuone,preview,noselect,noinsert
" Show symbol information in a popup window
set completeopt=menu,menuone,popup,noselect,noinsert
set completepopup=align:menu,border:off

" Set LSP settings
" Aligning below seems to offset the cursor line, possibly because of Unicode issues.
" Add this to get things like function parameter names:
" showInlayHints: v:true,
call LspOptionsSet(#{
    \hoverInPreview: v:false,
    \autoComplete: v:false,
    \omniComplete: v:true,
    \showDiagWithVirtualText: v:true,
    \ignoreMissingServer: v:true,
    \completionMatcher: 'fuzzy',
    \snippetSupport: v:true
\})
call LspAddServer([#{
    \name: 'rustanalyzer',
    \filetype: ['rust'],
    \path: 'rust-analyzer',
    \args: [],
    \syncInit: v:true,
\}])
call LspAddServer([#{name: 'gopls',
    \filetype: ['go', 'gomod'],
    \path: expand('$HOME/go/bin/gopls'),
    \args: ['serve'],
    \syncInit: v:true,
    \workspaceConfig: #{
    \    gopls: #{
    \        staticcheck: v:true,
    \        gofumpt: v:true,
    \        hints: #{ assignVariableTypes: v:true, constantValues: v:true, parameterNames: v:true },
    \    }
    \}
\}])

function! s:on_lsp_buffer_attached() abort
    " Shortcuts
    "nmap <silent> <C-]> <Cmd>LspGotoDefinition<CR>
    "nmap <silent> <C-W><C-]> :tab LspGotoDefinition<CR>
    nnoremap <buffer> gd <Cmd>LspGotoDefinition<CR>
    nnoremap <buffer> gD <Cmd>LspGotoDeclaration<CR>
    nnoremap <buffer> <C-W>gd :tab LspGotoDefinition<CR>
    nnoremap <buffer> gi <Cmd>LspGotoImpl<CR>
    nnoremap <buffer> gr <Cmd>LspShowReferences<CR>
    nnoremap <buffer> <space>pr <Cmd>LspPeekReferences<CR>
    nnoremap <buffer> [d <Cmd>LspDiag prev<CR>
    nnoremap <buffer> ]d <Cmd>LspDiag next<CR>
    nnoremap <buffer> <space>ca <Cmd>LspCodeAction<CR>
    nnoremap <buffer> <space>rn <Cmd>LspRename<CR>
    nnoremap <buffer> <space>e <Cmd>LspDiagCurrent<CR>
    nnoremap <buffer> <space>q <Cmd>LspDiagShow<CR>

    " Enable hover on K
    set keywordprg=:LspHover
    " Go to definition with LSP
    setlocal tagfunc=lsp#lsp#TagFunc
    " Set default formatter on gq
    setlocal formatexpr=lsp#lsp#FormatExpr()
    " Format on save
    augroup lsp_format
	autocmd! BufWritePre *.go,*.rs :LspFormat
    augroup END

    " Close preview window after completion
    au CompleteDone * pclose
endfunction

augroup lsp_install
    au!
    autocmd User LspAttached call s:on_lsp_buffer_attached()
augroup END

" Go options
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" Rust options
autocmd BufNewFile,BufRead *.rs set filetype=rust
