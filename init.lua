-- Behave like vim (middle-click paste)
vim.opt.mouse = ''
vim.opt.belloff = ''
-- vim.opt.errorbells = true
vim.opt.visualbell = true

vim.wo.number = true

vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.wildmode = 'longest:full,full'
-- vim.opt.wildoptions = 'pum,tagfile'
-- TODO: switch from preview to popup when nvim adds options to change popup settings
vim.opt.completeopt = 'menu,longest,noinsert,preview'

-- vim.cmd.colorscheme('habamax')

-- LSP configuration
vim.env.PATH = vim.env.PATH .. ':' .. vim.env.HOME ..  '/go/bin/'
local lspconfig = require('lspconfig')
lspconfig.gopls.setup({
  settings = {
    gopls = {
      staticcheck = true,
      gofumpt = true,
      -- Changes to advanced syntax highligting
      semanticTokens = true,
      usePlaceholders = true,
    },
  }
})
lspconfig.rust_analyzer.setup{
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true,
      },
      inlayHints = true,
    }
  }
}

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
vim.diagnostic.config({ float = { border = 'single' } })
require('lspconfig.ui.windows').default_options.border = 'single'
-- Restore nvim 0.9 (classic vim) style for popups and floating windows
-- vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Pmenu' })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- Enable completion triggered by <c-x><c-o>
    if client.server_capabilities.completionProvider then
      vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    end
    if client.server_capabilities.definitionProvider then
      vim.bo[args.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    -- Set rounded borders to separate from background
    require('lspconfig.ui.windows').default_options.border = 'rounded'
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

    -- Disable advanced syntax highlighting
    -- client.server_capabilities.semanticTokensProvider = nil
    vim.lsp.inlay_hint.enable(false)

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<C-w>gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = false } end, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>cc', vim.lsp.codelens.run, opts)
    vim.keymap.set('n', '<space>cC', vim.lsp.codelens.refresh, opts)
  end,
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go,*.rs',
  group = 'LspFormatting',
  callback = function()
    vim.lsp.buf.format({ async = true })
  end
})

vim.api.nvim_create_autocmd({"BufNewFile","BufRead"}, {
  pattern = "*.go",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
  end
})

-- Autoclose preview window (alternatively, use <C-w>z)
vim.api.nvim_create_autocmd('CompleteDone', { callback = function() vim.cmd.pclose() end })
