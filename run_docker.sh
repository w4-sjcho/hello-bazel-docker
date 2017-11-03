#!/usr/bin/env sh
set -e

bazel build --config=docker :hello
cp bazel-out/hello .
docker build .
