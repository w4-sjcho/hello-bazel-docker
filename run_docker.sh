#!/usr/bin/env sh
set -e

bazel build --config=docker :hello
cp bazel-out/hello .
docker build .
echo "Now run 'docker run \$IMAGE' where IMAGE is the output of the last line"
