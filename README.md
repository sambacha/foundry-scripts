# [`foundry-scripts`](https://github.com/sambacha/foundry-scripts)

<img alt="a picture of justfile recipes" align="right" src="https://raw.githubusercontent.com/sambacha/foundry-scripts/c6b6ef62dd0197975a765d655feae4302088bcef/.github/readme_justfile.svg" height="320"></img>

<br />
 
## Overview

[![justfile](https://github.com/sambacha/foundry-scripts/actions/workflows/justfile.yml/badge.svg)](https://github.com/sambacha/foundry-scripts/actions/workflows/justfile.yml) 
> GitHub Action verifes the recipes by creating a dummy foundry repo

> `just` is the new `make`

- load `.env` via `justfile`
- run tests;  etc etc
<br />

## Quickstart

In your repo, you execute the command `just` and add a `recipe` after to run the process

```shell
$ just
# just --list
Available recipes:
    build                     # [BUILD]: Timer
    build-mainnet             # [TEST] mainnet test
    deploy-contract           # [DEPLOY]: Deploy contract
    dumpbuild                 # Executes a dump of ethers-rs solc compiler output into two json files
    forge-gas-snapshot        # [GAS] get gas snapshot timer
    forge-gas-snapshot-diff
    gas-cov
    gas-snapshot              # [GAS] default gas snapshot script
    gas-snapshot-local        # [GAS] get gas snapshot from local tests and save it to file
    size                      # Contract Size
    sl
    test                      # [TEST] default test scripts
    test-debug *commands=""   # [TEST] run mainnet fork forge debug tests (all files with the extension .t.sol)
    test-local *commands=""   # [TEST] run local forge test using --match-path <PATTERN>
    test-mainnet *commands="" # [TEST] run mainnet fork forge tests (all files with the extension .t.sol)
    tl
    verify-contract           # [DEPLOY]: Verify contract
```

### two-letter recipes

```shell
just tl
```

```makefile
tl:
    forge test --list

sl:
    forge snapshot --list
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

### Developer notes

If you modify the `justfile`, run `just --fmt --unstable` and it will format the `justfile` itself.

## Repo Example

[see https://github.com/sambacha/foundry-justfile-example](https://github.com/sambacha/foundry-justfile-example)


## License

Apache-2.0/MIT
