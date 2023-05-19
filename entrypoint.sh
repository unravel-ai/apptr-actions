#!/bin/sh -l
#
mkdir -p $(dirname $1)
touch $1
echo "Generating output file: "$(ls $1)

chown $(id -g):$(id -u) -R ~/.cache

skaffold build --file-output="$1" \
  --default-repo="$2" --tag="$GITHUB_SHA"

chown 1001:1001 -R ~/.cache/bazel
