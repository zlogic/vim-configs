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
set completeopt=menu,menuone,popup,noselect,noinsert,fuzzy
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
    \diagVirtualTextAlign: 'above',
    \ignoreMissingServer: v:true,
    \completionMatcher: 'icase',
    \snippetSupport: v:false,
    \semanticHighlight: v:false,
    \condensedCompletionMenu: v:true
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
    \        semanticTokens: v:false,
    \        hints: #{ assignVariableTypes: v:true, constantValues: v:true, parameterNames: v:true },
    \    }
    \}
\}])

function! s:on_lsp_buffer_attached() abort
    " Shortcuts
    nnoremap <buffer> gd <Cmd>LspGotoDefinition<CR>
    nnoremap <buffer> gD <Cmd>LspGotoDeclaration<CR>
    nnoremap <buffer> <C-W>gd :tab LspGotoDefinition<CR>
    nnoremap <buffer> gi <Cmd>LspGotoImpl<CR>
    nnoremap <buffer> gr <Cmd>LspShowReferences<CR>
    nnoremap <buffer> <space>pr <Cmd>LspPeekReferences<CR>
    nnoremap <buffer> [d <Cmd>LspDiag prev<CR>
    nnoremap <buffer> ]d <Cmd>LspDiag next<CR>
    nnoremap <buffer> <space>ca <Cmd>LspCodeAction<CR>
    nnoremap <buffer> <space>cc <Cmd>LspCodeLens<CR>
    nnoremap <buffer> grn <Cmd>LspRename<CR>
    nnoremap <buffer> <space>e <Cmd>LspDiagCurrent<CR>
    nnoremap <buffer> <space>q <Cmd>LspDiagShow<CR>
    nnoremap <buffer> grr <Cmd>LspShowReferences<CR>
    nnoremap <buffer> gra <Cmd>LspCodeAction<CR>
    nnoremap <buffer> gri <Cmd>LspGotoImpl<CR>
    nnoremap <buffer> gO <Cmd>LspDocumentSymbol<CR>
    nnoremap <buffer> <C-S> <Cmd>LspShowSignature<CR>
    inoremap <buffer> <C-S> <Cmd>LspShowSignature<CR>

    nnoremap <buffer> <leader>fr <Cmd>LspPeekReferences<CR>
    nnoremap <buffer> <leader>fs <Cmd>LspDocumentSymbol<CR>
    nnoremap <buffer> <leader>fd <Cmd>LspPeekDefinition<CR>

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
