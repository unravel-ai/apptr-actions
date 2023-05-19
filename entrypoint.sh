#!/bin/sh -l
#
mkdir -p $(dirname $1)
touch $1
echo "Generating output file: "$(ls $1)

mkdir -p .cache/bazel
echo "build --disk_cache=.cache/bazel" >> .bazelrc

skaffold build --file-output="$1" \
  --default-repo="$2" --tag="$GITHUB_SHA"

