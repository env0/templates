package env0

# METADATA
# title: deny destroys
# description: destroys are not allowed in this project
other[format(rego.metadata.rule())]

format(meta) := meta.description
