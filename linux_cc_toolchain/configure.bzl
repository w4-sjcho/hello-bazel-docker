load(
    "@bazel_tools//tools/cpp:lib_cc_configure.bzl",
    "get_cpu_value",
)

def _configure_linux_cc_toolchain_impl(repository_ctx):
    cpu = get_cpu_value(repository_ctx)

    if cpu == "darwin":
        repository_ctx.extract(
            repository_ctx.attr._x_tools,
            output = "",
            stripPrefix = "x-tools/x86_64-unknown-linux-gnu",
        )
        toolchains = "{\"darwin\": \":darwin_ct_ng\"}"
    elif cpu == "k8":
        toolchains = "{\"k8\": \"@local_config_cc//:cc-compiler-k8\"}"

    repository_ctx.template(
        "BUILD",
        repository_ctx.attr._build_tpl,
        substitutions = {
            "\"%{toolchains}\"": toolchains,
        },
    )

configure_linux_cc_toolchain = repository_rule(
    implementation = _configure_linux_cc_toolchain_impl,
    attrs = {
        "_x_tools": attr.label(
            default = "@//:linux_cc_toolchain/x-tools-2019-12-03.tar.xz",
        ),
        "_build_tpl": attr.label(
            default = "@//:linux_cc_toolchain/tpl.BUILD",
        ),
    },
)
