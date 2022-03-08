#!/usr/bin/env bash

function combine_artifact_json
{
    # Combine all dicts into a list with `jq --slurp` and then use `reduce` to merge them into one
    # big dict with keys of the form `"<file>:<contract>"`. Then run jq again to filter out items
    # with zero size and put the rest under under a top-level `bytecode_size` key. Also add another
    # key with total bytecode size.
    # NOTE: The extra inner `bytecode_size` key is there only to make diffs more readable.
    cat - |
        jq --slurp 'reduce (.[] | to_entries[]) as {$key, $value} ({}; . + {
            ($key + ":" + ($value | to_entries[].key)): {
                bytecode_size: $value | to_entries[].value
            }
        })' |
        jq --indent 4 --sort-keys '{
            bytecode_size: [. | to_entries[] | select(.value.bytecode_size > 0)] | from_entries,
            total_bytecode_size: (reduce (. | to_entries[]) as {$key, $value} (0; . + $value.bytecode_size))
        }'
}
