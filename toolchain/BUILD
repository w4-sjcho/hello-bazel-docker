package(default_visibility = ["//visibility:public"])

cc_toolchain_suite(
    name = "docker",
    toolchains = {
        "docker|clang": "docker_toolchain",
    },
)

filegroup(name = "empty")

filegroup(
    name = "all",
    srcs = [
        "clang.sh",
        "@docker_toolchain//:all",
    ],
)

cc_toolchain(
    name = "docker_toolchain",
    all_files = ":all",
    compiler_files = ":all",
    cpu = "docker",
    dwp_files = ":empty",
    dynamic_runtime_libs = [":empty"],
    linker_files = ":all",
    objcopy_files = ":empty",
    static_runtime_libs = [":empty"],
    strip_files = ":empty",
    supports_param_files = 0,
)
