package env0

# METADATA
# title: allow always
# description: allows automatically if not a destroy
allow[format(rego.metadata.rule())]

format(meta) := meta.description
