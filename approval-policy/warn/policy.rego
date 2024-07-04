package env0
# METADATA
# title: always warn
# description: YOU HAVE BEEN WARNED
warn[format(rego.metadata.rule())] {
	1 == 1
}

format(meta) := meta.description