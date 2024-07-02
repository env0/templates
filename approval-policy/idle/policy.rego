package env0

allow[format(rego.metadata.rule())] {
	0 >= 1
}

format(meta) := meta.description