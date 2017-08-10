#!/bin/bash

EGO_PN=$1

curl -sS https://api.github.com/repos/${EGO_PN#github.com/}/commits/HEAD | jq -r .sha
