#!/usr/bin/env bash
echo "Reading src dir and sorting files..."
export LC_ALL=C
tests_to_run=$(find src/ -name "*.sol" ! -path "src" | LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3 -o index.txt)
echo $tests_to_run
if [ "$?" -eq "0" ]
then
    echo "...."
    echo "Success:"
    echo "Output witten to index.txt file"
    exit 0
else
    echo "...."
    echo "Error:"
    echo "Exception, unable to write results"
    exit 1
fi

exit 127
