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
vim.opt.completeopt = 'menu,menuone,popup,noselect,noinsert,fuzzy'

-- vim.cmd.colorscheme('habamax')

-- Monitor external FS changes (e.g. from git)
vim.o.autoread = true

-- LSP configuration
vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    },
  }
})
vim.lsp.enable({'rust-analyzer', 'gopls'})

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
vim.diagnostic.config({
  float = { border = 'single' },
  -- Show multiline diagnostics
  virtual_lines = true
  -- virtual_text = true
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- Enable navigation with <C-]>
    if client.server_capabilities.definitionProvider then
      vim.bo[args.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    -- Enable snippet completion
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, args.data.client_id, args.buf, {autotrigger = true})
    end

    -- Temporary workaround to force rounded borders in omnifunc.
    -- Remove once this is fixed in https://github.com/neovim/neovim/pull/25541.
    vim.api.nvim_create_autocmd('CompleteChanged', {
      buffer = args.buf,
      callback = function (args)
        local info = vim.fn.complete_info({'selected'})
        local floating_winnr = info['preview_winid']
        if floating_winnr ~= nil and vim.api.nvim_win_is_valid(floating_winnr) then
          local opts = vim.api.nvim_win_get_config(floating_winnr)
          if opts.width > 2 then
            opts.border = 'single'
            opts.width = opts.width - 2
            vim.api.nvim_win_set_config(floating_winnr, opts)
          end
        end
      end
    })

    -- Disable tree-sitter if semantic token provider is enabled
    -- At the moment, only [tree-sitter + semantic tokens] or only [semantic-tokens]
    -- work correctly - see https://github.com/neovim/neovim/issues/33358.
    if client.server_capabilities.semanticTokensProvider then
      -- vim.treesitter.stop(args.buf)
    end
    -- Disable inlay hints that might look like code
    -- vim.lsp.inlay_hint.enable(true)
    -- Set rounded borders to separate from background
    vim.o.winborder = 'rounded'
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

    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('LspFormatting', {clear=false}),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
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
