#!/bin/sh -l

skaffold build --file-output=$1 \
  --default-repo=${{ secrets.IMAGE_REGISTRY }} --tag=${{ github.sha }}

