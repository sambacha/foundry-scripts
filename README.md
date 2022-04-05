# `foundry-scripts`

> justfile and shell scripts

## Overview

> `just` is the new `make`

- load `.env` via `justfile`
- run tests
- can even execute nodejs/python/etc scripts via `justfile`


## Example

```shell
$ just
just --list
Available recipes:
    build                     # build using forge
    test                      # default test scripts
    test-local *commands=""
    test-mainnet *commands="" # run mainnet fork forge tests (all files with the extension .debug.sol)
```


## Repo Example

[see https://github.com/sambacha/foundry-justfile-example](https://github.com/sambacha/foundry-justfile-example)


## License

Apache-2.0/MIT
