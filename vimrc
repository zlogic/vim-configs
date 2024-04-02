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
nmap <silent> <C-]> :LspGotoDefinition<CR>
nmap <silent> <C-W><C-]> :tab LspGotoDefinition<CR>
nmap <silent> <C-k> :LspDiag prev<CR>
nmap <silent> <C-j> :LspDiag next<CR>
nmap <silent> gd :LspGotoDefinition<CR>
nmap <silent> gD :LspGotoDeclaration<CR>
nmap <silent> <C-W>gd :tab LspGotoDefinition<CR>
nmap <silent> gr :LspShowReferences<CR>
nmap <silent> [d :LspDiag prev<CR>
nmap <silent> ]d :LspDiag next<CR>
nmap <silent> <space>ca :LspCodeAction<CR>
nmap <silent> <space>rn :LspRename<CR>

" noremap Y "+y
" nnoremap YY "+yy

" Show autocomplete description in preview pane
" set completeopt=menu,menuone,preview,noselect,noinsert
" Show symbol information in a popup window
set completeopt=menu,menuone,popup,noselect,noinsert

" Set LSP settings
call LspOptionsSet(#{
    \hoverInPreview: v:false,
    \autoComplete: v:false,
    \omniComplete: v:true,
    \showDiagWithVirtualText: v:true,
    \ignoreMissingServer: v:true,
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
    \    }
    \}
\}])

" Enable hover on K
set keywordprg=:LspHover
" Format on save
augroup lsp_format
    autocmd! BufWritePre *.go,*.rs :LspFormat
augroup END

" Go options
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" Rust options
autocmd BufNewFile,BufRead *.rs set filetype=rust
