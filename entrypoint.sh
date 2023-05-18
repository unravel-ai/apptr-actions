#!/bin/sh -l

skaffold build --file-output="$1" \
  --default-repo="$2" --tag="$GITHUB_SHA"

