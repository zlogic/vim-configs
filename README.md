# Neovim configs

This repo contains my `~/.config/nvim` directory.

For language support and other features, plugins are required:

* [lspconfig](https://github.com/neovim/nvim-lspconfig)
* [telescope](https://github.com/nvim-telescope/telescope.nvim) and its dependencies:
  * [plenary](https://github.com/nvim-lua/plenary.nvim)
  * [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

Install them by running

```shell
git clone https://github.com/neovim/nvim-lspconfig.git ~/.config/nvim/pack/plugins/start/lspconfig
git clone https://github.com/nvim-lua/plenary.nvim.git ~/.config/nvim/pack/plugins/start/plenary.nvim
git clone https://github.com/nvim-telescope/telescope.nvim.git ~/.config/nvim/pack/plugins/start/telescope.nvim
git clone https://github.com/nvim-treesitter/nvim-treesitter.git ~/.config/nvim/pack/plugins/start/nvim-treesitter.git
```

## Go

Go requires the [gopls](https://github.com/golang/tools) language server to be installed.

```shell
go install golang.org/x/tools/gopls@latest
```

In addition, the [staticcheck](https://github.com/dominikh/go-tools) linter should be installed as well:

```shell
go install honnef.co/go/tools/cmd/staticcheck@2023.1.7
```

## Rust

Rust requires the [rust-analyzer](https://github.com/rust-lang/rust-analyzer) to be installed.

```shell
rustup component add rust-analyzer
```
