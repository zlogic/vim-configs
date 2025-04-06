vim.env.PATH = vim.env.PATH .. ':' .. vim.env.HOME ..  '/go/bin/'
return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.mod' },
  settings = {
    gopls = {
      staticcheck = true,
      gofumpt = true,
      -- Change to advanced syntax highlighting
      -- semanticTokens = true,
      usePlaceholders = false,
      -- Enable additional code lenses
      -- codelenses = {
      --   test = true
      -- }
    }
  },
  on_init = function(client, _)
    -- Disable advanced syntax highlighting, as it duplicates tree-sitter
    -- This will only work when https://github.com/neovim/neovim/issues/33358 is addressed
    -- client.server_capabilities.semanticTokensProvider = nil
  end
}
