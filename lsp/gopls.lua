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
}
