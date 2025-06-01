# Neovim configs

This repo contains my `~/.config/nvim` directory.

For language support and other features, plugins are required:

* [telescope](https://github.com/nvim-telescope/telescope.nvim) and its dependencies:
  * [plenary](https://github.com/nvim-lua/plenary.nvim)
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

Install them by running

```shell
git clone --depth 1 --single-branch --branch main https://github.com/nvim-treesitter/nvim-treesitter.git ~/.config/nvim/pack/plugins/start/nvim-treesitter
git clone --depth 1 https://github.com/nvim-telescope/telescope.nvim.git ~/.config/nvim/pack/plugins/start/telescope.nvim
git clone --depth 1 https://github.com/nvim-treesitter/nvim-treesitter.git ~/.config/nvim/pack/plugins/start/nvim-treesitter
```

There's a lot of useful LSP advice [in the Neovim's LSP guide](https://vonheikemen.github.io/devlog/tools/neovim-lsp-client-guide/)

# Tree-sitter

The main tree-sitter branch requires the [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter) in the `$PATH`, and a C compiler.

Those tools are only needed when running `:TSInstall` or `:TSUpdate`.

To diagnose tree-sitter, run `:checkhealth nvim-treesitter`.

## Go

Go requires the [gopls](https://github.com/golang/tools) language server to be installed.

```shell
go install golang.org/x/tools/gopls@latest
```

In addition, the [staticcheck](https://github.com/dominikh/go-tools) linter should be installed as well:

```shell
go install honnef.co/go/tools/cmd/staticcheck@2025.1.1
```

To install the treesitter modules, run:

```vim
:TSInstall go
```

## Rust

Rust requires the [rust-analyzer](https://github.com/rust-lang/rust-analyzer) to be installed.

```shell
rustup component add rust-analyzer
```

To install the treesitter modules, run:

```vim
:TSInstall rust
```
