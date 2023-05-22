#!/bin/sh -l
#
mkdir -p $(dirname $1)
touch $1
echo "Generating output file: "$(ls $1)

# mkdir -p ~/.cache/bazel

mkdir -p /tmp/bazel_s3_cache 
bazel-remote -dir=/tmp/bazel_s3_cache --s3.region=us-east-2 --s3.bucket=apptr-ci-cd-cache --s3.access_key_id=$BAZEL_REMOTE_CACHE_S3_ID --s3.secret_access_key='$BAZEL_REMOTE_CACHE_S3_KEY' --max_size=5 --s3.auth_method=access_key --s3.endpoint=s3.us-east-2.amazonaws.com --port=9090
# chown $(id -g):$(id -u) -R ~/.cache

skaffold build --file-output="$1" \
  --default-repo="$2" --tag="$GITHUB_SHA"

# chown 1001:1001 -R ~/.cache/bazel
