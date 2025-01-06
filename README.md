# Neovim configs

This repo contains my `~/.config/nvim` directory.

For language support and other features, plugins are required:

* [lspconfig](https://github.com/neovim/nvim-lspconfig)
* [telescope](https://github.com/nvim-telescope/telescope.nvim) and its dependencies:
  * [plenary](https://github.com/nvim-lua/plenary.nvim)
* [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

Install them by running

```shell
git clone --depth 1 https://github.com/neovim/nvim-lspconfig.git ~/.config/nvim/pack/plugins/start/lspconfig
git clone --depth 1 https://github.com/nvim-lua/plenary.nvim.git ~/.config/nvim/pack/plugins/start/plenary.nvim
git clone --depth 1 https://github.com/nvim-telescope/telescope.nvim.git ~/.config/nvim/pack/plugins/start/telescope.nvim
git clone --depth 1 https://github.com/nvim-treesitter/nvim-treesitter.git ~/.config/nvim/pack/plugins/start/nvim-treesitter
```

```shell
git clone --depth 1 https://github.com/hrsh7th/nvim-cmp.git ~/.config/nvim/pack/plugins/start/nvim-cmp
git clone --depth 1 https://github.com/hrsh7th/cmp-nvim-lsp.git ~/.config/nvim/pack/plugins/start/cmp-nvim-lsp
git clone --depth 1 https://github.com/hrsh7th/cmp-path.git ~/.config/nvim/pack/plugins/start/cmp-path
git clone --depth 1 https://github.com/hrsh7th/cmp-cmdline.git ~/.config/nvim/pack/plugins/start/cmp-cmdline
git clone --depth 1 https://github.com/hrsh7th/cmp-nvim-lsp-signature-help ~/.config/nvim/pack/plugins/start/nvim-lsp-signature-help
```

## Go

Go requires the [gopls](https://github.com/golang/tools) language server to be installed.

```shell
go install golang.org/x/tools/gopls@latest
```

In addition, the [staticcheck](https://github.com/dominikh/go-tools) linter should be installed as well:

```shell
go install honnef.co/go/tools/cmd/staticcheck@2024.1.1
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
