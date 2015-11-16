#!/bin/sh

set -e
set -x

REPO=quay.io/coreos/quay-docs

docker build -t $REPO .
docker run -it -p 4000:4000 $REPO
