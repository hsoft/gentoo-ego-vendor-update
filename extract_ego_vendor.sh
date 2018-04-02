#!/bin/bash

echo "EGO_VENDOR=("

find "$1/github.com" -name ".git" -type d -printf "%P\n" | while read line; do
    reponame=$(dirname $line)
    repopath="$1/github.com/$reponame"
    printf "\t\"github.com/%s %s\"\n" "$reponame" $(git -C "${repopath}" rev-parse HEAD)
done

for path in $1/golang.org/x/*; do
    reponame=$(basename $path)
    repopath="$1/golang.org/x/$reponame"
    printf "\t\"golang.org/x/%s %s github.com/golang/%s\"\n" $reponame $(git -C "${repopath}" rev-parse HEAD) $reponame
done

find "$1/gopkg.in" -name ".git" -type d -printf "%P\n" | while read line; do
    reponame=$(dirname $line)
    repopath="$1/gopkg.in/$reponame"
    gopkgurl="https://gopkg.in/$reponame"
    githuburl=$(curl -s $gopkgurl | grep -Eo "github.com/[^/]+/[^/]+/tree/[^\"]+")
    # example result: github.com/go-macaroon/macaroon/tree/v2
    githubname=$(echo $githuburl | cut -d / -f 1-3)
    githubbranch=$(echo $githuburl | cut -d / -f 5)
    printf "\t\"gopkg.in/%s %s %s\" # branch %s\n" $reponame $(git -C "${repopath}" rev-parse HEAD) $githubname $githubbranch
done

echo ")"
