workspace(name = "hello_bazel_docker")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//:local.bzl", "local_archive")

local_archive(
    name = "ubuntu18_04_toolchain",
    build_file = "//:toolchains/ubuntu18_04_toolchain.BUILD",
    strip_prefix = "x-tools/x86_64-unknown-linux-gnu",
    # sha256 = "1bf50eef9a3a1970fcacf4ca24b314184b783a0d056cda2b6f2f874411b54d67",
    # url = "https://www.corp.skelterlabs.com/sjcho/x-tools-2019-12-03.tar.gz",
    path = "//:x-tools-2019-12-03.tar.xz",
)
