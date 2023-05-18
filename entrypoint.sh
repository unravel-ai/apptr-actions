#!/bin/sh -l



skaffold build --file-output="$2" \
  --default-repo="$3" --tag="$1"

