# Vim configs

This repo contains my `.vim` directory.

For language support and other features, plugins are required:

* [ALE](https://github.com/dense-analysis/ale)
* ~~[vim-go](https://github.com/fatih/vim-go)~~
* [rust-vim](https://github.com/rust-lang/rust.vim)


Install them by running

```shell
# git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
git clone https://github.com/rust-lang/rust.vim ~/.vim/pack/plugins/start/rust.vim
git clone --depth 1 https://github.com/dense-analysis/ale.git ~/.vim/pack/plugins/start/ale
```

## Go

Go requires the [gopls](https://github.com/golang/tools) language server to be installed.

```shell
go install golang.org/x/tools/gopls@latest
```

In addition, the [staticcheck](https://github.com/dominikh/go-tools) linter should be installed as well:

```shell
go install honnef.co/go/tools/cmd/staticcheck@2023.1.3
```

## Rust

Rust requires the [rust-analyzer](https://github.com/rust-lang/rust-analyzer) to be installed.

```shell
rustup component add rust-analyzer
```

## Neovim branch

There's also a [Neovim](../../tree/neovim) branch, but it's less actively maintained (I ended up preferring Vim + ALE).
