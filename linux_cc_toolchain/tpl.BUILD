package(default_visibility = ["//visibility:public"])

load("@//:linux_cc_toolchain/ct_ng_config.bzl", "ct_ng_toolchain_config")

filegroup(name = "empty")

filegroup(
    name = "all",
    srcs = glob(["**/*"]),
)

ct_ng_toolchain_config(
    name = "darwin_ct_ng_config",
    compiler = "gcc-8.3.0",
    host_system_name = "x86_64-apple-darwin",
    target_libc = "glibc-2.29",
    target_system_name = "x86_64-unknown-linux-gnu",
)

cc_toolchain(
    name = "darwin_ct_ng",
    all_files = ":all",
    compiler_files = ":all",
    dwp_files = ":empty",
    linker_files = ":all",
    objcopy_files = ":empty",
    strip_files = ":all",
    supports_param_files = True,
    toolchain_config = ":darwin_ct_ng_config",
)

cc_toolchain_suite(
    name = "toolchain",
    toolchains = "%{toolchains}",
)
