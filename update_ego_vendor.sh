#!/bin/bash

EBUILD_PATH=$1

echo "EGO_VENDOR=("

sed -n -r 's#\s*"github.com/(.+) [0-9a-f]+"#\1#p' "$EBUILD_PATH" | while read -r line
do
    printf "\t\"github.com/%s %s\"\n" "${line}" "$( ./github_head.sh "${line}" )"
done

sed -n -r 's#\s*"(.+) [0-9a-f]+ github.com/(.+)"#\1 \2#p' "$EBUILD_PATH" | while read -r line
do
    words=( $line )
    printf "\t\"%s %s github.com/%s\"\n" "${words[0]}" "$( ./github_head.sh "${words[1]}" )" "${words[1]}"
done

echo ")"
