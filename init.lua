-- Behave like vim (middle-click paste)
-- Disabled because Neovim doesn't handle rapid input of ESC characters well
-- vim.opt.mouse = ''
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
vim.opt.wildoptions = 'pum,tagfile'
-- In NeoVim 0.11, add the fuzzy option.
vim.opt.completeopt = 'menu,menuone,popup,noselect,noinsert'

-- vim.cmd.colorscheme('habamax')

-- LSP configuration
vim.env.PATH = vim.env.PATH .. ':' .. vim.env.HOME ..  '/go/bin/'
local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Snippets
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.keymap.set({ 'i', 's' }, '<Tab>', function()
  return vim.snippet.active({ direction = 1 }) and '<cmd>lua vim.snippet.jump(1)<cr>' or '<Tab>'
end, { expr = true, silent = true })
vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
  return vim.snippet.active({ direction = -1 }) and '<cmd>lua vim.snippet.jump(-1)<cr>' or '<S-Tab>'
end, { expr = true, silent = true })

lspconfig.gopls.setup({
  settings = {
    gopls = {
      staticcheck = true,
      gofumpt = true,
      -- Change to advanced syntax highlighting
      -- semanticTokens = true,
      usePlaceholders = false,
    },
  },
  capabilities = capabilities,
})
lspconfig.rust_analyzer.setup{
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true,
      },
      -- inlayHints = true,
    }
  }
}

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
vim.diagnostic.config({
  float = { border = 'single' },
  virtual_text = true
})
require('lspconfig.ui.windows').default_options.border = 'single'

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- Enable navigation with <C-]>
    if client.server_capabilities.definitionProvider then
      vim.bo[args.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    -- Enable autotrigger completion when NeoVim 0.11 becomes available.
    -- vim.lsp.completion.enable(true, args.data.client_id, args.buf, {autotrigger = true})

    -- Temporary workaround to force rounded borders in omnifunc.
    -- Remove once this is fixed in https://github.com/neovim/neovim/pull/25541.
    vim.api.nvim_create_autocmd('CompleteChanged', {
      buffer = args.buf,
      callback = function (args)
        local info = vim.fn.complete_info({'selected'})
        local floating_winnr = info['preview_winid']
        if floating_winnr ~= nil and vim.api.nvim_win_is_valid(floating_winnr) then
          local opts = vim.api.nvim_win_get_config(floating_winnr)
          opts.border = 'single'
          opts.width = opts.width - 2
          vim.api.nvim_win_set_config(floating_winnr, opts)
        end
      end
    })

    -- Disable advanced syntax highlighting
    client.server_capabilities.semanticTokensProvider = nil
    -- Disable inlay hints that might look like code
    vim.lsp.inlay_hint.enable(false)
     -- Set rounded borders to separate from background
    require('lspconfig.ui.windows').default_options.border = 'rounded'
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })

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
    vim.lsp.buf.format({ async = false })
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

-- Telescope shortcuts
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>fs', builtin.lsp_workspace_symbols, {})
vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader>fts', builtin.treesitter, {})

-- Tree-sitter
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
  },
}
