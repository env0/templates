package env0

# METADATA
# title: allow always
# description: allows automatically if not a destroy
allow[format2(rego.metadata.rule())] {
	print(input)
}

format2(meta) := meta.description
