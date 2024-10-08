# Vim configs

This repo contains my `.vim` directory.

For language support and other features, plugins are required:

* [lsp](https://github.com/yegappan/lsp)
* ~~[ALE](https://github.com/dense-analysis/ale)~~
* ~~[vim-go](https://github.com/fatih/vim-go)~~
* [rust-vim](https://github.com/rust-lang/rust.vim)


Install them by running

```shell
git clone --depth 1 https://github.com/rust-lang/rust.vim ~/.vim/pack/plugins/start/rust.vim
git clone --depth 1 https://github.com/yegappan/lsp.git ~/.vim/pack/downloads/opt/lsp
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

## Rust

Rust requires the [rust-analyzer](https://github.com/rust-lang/rust-analyzer) to be installed.

```shell
rustup component add rust-analyzer
```

## Neovim branch

There's also a [Neovim](../../tree/neovim) branch, but it's less actively maintained (I ended up preferring Vim + LSP).
