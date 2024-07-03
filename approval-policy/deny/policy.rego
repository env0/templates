package env0
# METADATA
# title: always deny
# description: DENIED BITCH
deny[format(rego.metadata.rule())] {
	1 == 1
}

format(meta) := meta.description