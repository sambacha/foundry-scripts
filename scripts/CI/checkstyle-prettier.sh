#!/bin/bash -e

# Check if the style of the Solidity files is correct without modifying those
# files.

# The `prettier` utility doesn't provide a "diff" option. Therefore, we have
# to do this in a convoluted fashion to get a diff from the current state to
# what `prettier` considers correct and reporting, via the exit status, that
# the check failed.

# We predicate the detailed diff on being in a CI environment since we don't
# care if the files are modified. If not, just list the pathnames that need to
# be reformatted without actually modifying those files.

if test "$CI" = ""; then
    echo 'Solidity files that need changes:'
    ! find . -name '*.sol' |
        xargs prettier --list-different |
        sed 's/^/  /' | grep . && echo '  [PASS]!'
else
    echo 'Solidity files need these changes:'
    if ! find . -name '*.sol' | xargs prettier --check >/dev/null; then
        find . -name '*.sol' | xargs prettier --write >/dev/null
        find . -name '*.sol' | xargs git diff
        exit 1
    fi
    echo '  [PASS]!'
fi
exit 0
