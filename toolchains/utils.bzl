def cc_toolchain_suite_with_optionals(name, toolchains):
    new_toolchains = {}
    for key, value in toolchains.items():
        if value.startswith(":") or native.existing_rule(value):
            new_toolchains[key] = value
    native.cc_toolchain_suite(name = name, toolchains = new_toolchains)
