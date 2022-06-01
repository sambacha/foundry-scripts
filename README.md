# `foundry-scripts`

> `justfile` and shell scripts

## Overview

> `just` is the new `make`

- load `.env` via `justfile`
- run tests
- can even execute nodejs/python/etc scripts via `justfile`


## Quickstart

In your repo, you execute the command `just` 

```shell
$ just
just --list
Available recipes:
    build                     # build using forge
    test                      # default test scripts
    test-local *commands=""
    test-mainnet *commands="" # run mainnet fork forge tests (all files with the extension .debug.sol)
```

### ZSH Completions

In .zlogin:
```zsh
fpath=($HOME/.zsh/completion $fpath)

autoload -Uz compinit
compinit -u
```
In `$HOME/.zsh/completion/_just`

```shell
#compdef _just just
#autoload

_just () {
    local -a subcmds

    subcmds=($(just --summary))

    _describe 'command' subcmds
}

_just "$@"
```

### FiSH

> completions/just.fish:

```fish
complete -c just -a (just --summary)
```

### Bash v4.2+

> Simple.
> 
```bash
complete -W '$(just --summary)' just
```
> Alt.

```bash
if [ -f justfile ]; then
    complete -W "`just --summary`" just
fi

# ex: ts=4 sw=4 et filetype=sh
```


## Repo Example

[see https://github.com/sambacha/foundry-justfile-example](https://github.com/sambacha/foundry-justfile-example)


## License

Apache-2.0/MIT
