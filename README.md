# Neovim configs

This repo contains my `~/.config/nvim` directory.

For language support and other features, plugins are required:

* [lspconfig](https://github.com/neovim/nvim-lspconfig)

Install them by running

```shell
git clone https://github.com/neovim/nvim-lspconfig.git ~/.config/nvim/pack/plugins/start/lspconfig
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
