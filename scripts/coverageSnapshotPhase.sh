#!/usr/bin/env bash

# cd to the root of the repo
cd "$(git rev-parse --show-toplevel)"

coverageSnapshotPhase() 
{
    mkdir -p $PWD/.coverage/ 
    genhtml lcov.info -o $PWD/.coverage > log
    # genhtml lcov.info $lcovExtraTraceFiles -o $out/.coverage > log
    lineCoverage="$(sed 's/.*lines\.*: \([0-9\.]\+\)%.*/\1/; t ; d' log)"
    functionCoverage="$(sed 's/.*functions\.*: \([0-9\.]\+\)%.*/\1/; t ; d' log)"
        if [ -z "$lineCoverage" -o -z "$functionCoverage" ]; then
            echo "⛔︎ Failed to get coverage statistics"
            exit 1
        fi
    echo "lineCoverage $lineCoverage %" >> $out/.coverage/snapshot
    echo "functionCoverage $functionCoverage %" >> $out/.coverage/snapshot
    touch $out/.coverage/snapshot/CI_TIMESTAMP
    date +"%Y%m%d%H%M%S" >> $out/.coverage/snapshot/CI_TIMESTAMP
    # cleanup
    rm log
}

coverageSnapshotPhase
