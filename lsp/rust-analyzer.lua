return {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml' },
  settings = {
    autoformat = true,
    ['rust-analyzer'] = {
      -- check = { command = 'clippy' }
    }
  },
  capabilities = {
    experimental = {
      serverStatusNotification = true,
    }
  },
  on_init = function(client, _)
    -- Disable advanced syntax highlighting, as it duplicates tree-sitter
    -- This will only work when https://github.com/neovim/neovim/issues/33358 is addressed
    -- client.server_capabilities.semanticTokensProvider = nil
  end
}
