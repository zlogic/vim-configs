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
  }
}
