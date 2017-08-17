#!/bin/bash

EGO_PN=$1
GIT_BRANCH=${2:-HEAD}

curl -sS "https://api.github.com/repos/${EGO_PN#github.com/}/commits/${GIT_BRANCH}" | jq -r .sha
