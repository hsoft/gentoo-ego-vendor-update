#!/bin/bash

EBUILD_PATH=$1

echo "EGO_VENDOR=("

sed -n -r 's!\s*"github.com/(.+) [0-9a-f]+"( # branch )?(\w+)?!\1 \3!p' "$EBUILD_PATH" | while read -r line
do
    words=( $line )
    printf "\t\"github.com/%s %s\"\n" "${line}" "$( ./github_head.sh "${line}" )"
done

sed -n -r 's!\s*"(.+) [0-9a-f]+ github.com/(.+)"( # branch )?(\w+)?!\1 \2 \4!p' "$EBUILD_PATH" | while read -r line
do
    words=( $line )
    git_branch=${words[2]}
    commit_hash=$( ./github_head.sh "${words[1]}" "${git_branch}" )
    if [ ! -z "$git_branch" ]; then
        line_suffix=" # branch ${git_branch}"
    fi
    printf "\t\"%s %s github.com/%s\"%s\n" "${words[0]}" "${commit_hash}" "${words[1]}" "${line_suffix}"
done

echo ")"
