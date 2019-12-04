def bind_if_exists(name, rule):
    if native.existing_rule(rule):
        native.bind(
            name = name,
            actual = rule,
        )
