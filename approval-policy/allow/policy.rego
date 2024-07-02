package env0
# METADATA
# title: always allow
# description: approved
allow[format(rego.metadata.rule())] {
	1 == 1
}

format(meta) := meta.description