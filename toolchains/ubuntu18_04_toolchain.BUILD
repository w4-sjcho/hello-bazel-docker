package(default_visibility = ["//visibility:public"])

load("@//:toolchains/ct_ng_config.bzl", "ct_ng_toolchain_config")
load("@//:toolchains/utils.bzl", "cc_toolchain_suite_with_optionals")

filegroup(name = "empty")

filegroup(
    name = "all",
    srcs = glob(["**/*"]),
)

ct_ng_toolchain_config(
    name = "ubuntu18_04_from_darwin_config",
    host_system_name = "x86_64-apple-darwin",
    compiler = "gcc-8.3.0",
    target_libc = "glibc-2.29",
    target_system_name = "x86_64-unknown-linux-gnu",
)

cc_toolchain(
    name = "ubuntu18_04_from_darwin",
    all_files = ":all",
    compiler_files = ":all",
    dwp_files = ":empty",
    linker_files = ":all",
    objcopy_files = ":empty",
    strip_files = ":all",
    supports_param_files = True,
    toolchain_config = ":ubuntu18_04_from_darwin_config",
)

cc_toolchain_suite_with_optionals(
    name = "ubuntu18_04",
    toolchains = {
        "darwin": ":ubuntu18_04_from_darwin",
        "k8": "@local_config_cc//:cc-compiler-k8",
    },
)
