
# toolchain/cc_toolchain_config.bzl:
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
     "feature",
     "flag_group",
     "flag_set",
     "tool_path")
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

def _impl(ctx):
    workspace_root = ctx.label.workspace_root
    name = ctx.attr.name
    target_system_name = ctx.attr.target_system_name
    compiler = ctx.attr.compiler
    compiler_version = compiler.split('-')[-1]
    target_libc = ctx.attr.target_libc
    tool_paths = [
        tool_path(
            name = "gcc",
            path = "bin/%s-gcc" % target_system_name,
        ),
        tool_path(
            name = "ld",
            path = "bin/%s-ld" % target_system_name,
        ),
        tool_path(
            name = "ar",
            path = "bin/%s-ar" % target_system_name,
        ),
        tool_path(
            name = "cpp",
            path = "bin/%s-cpp" % target_system_name,
        ),
        tool_path(
            name = "gcov",
            path = "bin/%s-gconv" % target_system_name,
        ),
        tool_path(
            name = "nm",
            path = "bin/%s-nm" % target_system_name,
        ),
        tool_path(
            name = "objdump",
            path = "bin/%s-objdump" % target_system_name,
        ),
        tool_path(
            name = "strip",
            path = "bin/%s-strip" % target_system_name,
        ),
    ]
    print(ctx.workspace_name)
    toolchain_include_directories_feature = feature(
        name = "toolchain_include_directories",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.assemble,
                    ACTION_NAMES.preprocess_assemble,
                    ACTION_NAMES.linkstamp_compile,
                    ACTION_NAMES.c_compile,
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_header_parsing,
                    ACTION_NAMES.cpp_module_compile,
                    ACTION_NAMES.cpp_module_codegen,
                    ACTION_NAMES.lto_backend,
                    ACTION_NAMES.clif_match,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-I%s/%s/sysroot/usr/include" % (workspace_root, target_system_name),
                            "-I%s/%s/include/c++/%s" % (workspace_root, target_system_name, compiler_version),
                            "-I%s/lib/gcc/%s/%s/include" % (workspace_root, target_system_name, compiler_version),
                        ],
                    ),
                ],
            ),
        ],
    )
    return [cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = name,
        host_system_name = ctx.attr.host_system_name,
        target_system_name = target_system_name,
        target_cpu = target_system_name.split('-')[0],
        target_libc = target_libc,
        compiler = compiler,
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
        # cxx_builtin_include_directories = [
        #     "%s/sysroot/usr/include" % ( target_system_name),
        #     "%s/include/c++/%s" % ( target_system_name, compiler_version),
        #     "lib/gcc/%s/%s/include" % ( target_system_name, compiler_version),
        # ]
        features = [toolchain_include_directories_feature],
    )]

ct_ng_toolchain_config = rule(
    implementation = _impl,
    attrs = {
        # e.g. "darwin"
        "host_system_name": attr.string(mandatory=True),
        # e.g. x86_64-unknown-linux-gnu
        "target_system_name": attr.string(mandatory=True),
        # e.g. glibc-2.29
        "target_libc": attr.string(mandatory=True),
        # e.g. gcc-8.3.0
        "compiler": attr.string(mandatory=True),
    },
    provides = [CcToolchainConfigInfo],
)
