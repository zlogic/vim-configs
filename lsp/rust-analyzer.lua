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
    -- client.server_capabilities.semanticTokensProvider = nil
  end
}
