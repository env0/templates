package env0

my_print(msg) {
	format_print(msg)
}

format_print(msg) {
	print(msg)
}

my_print(input) = true

# METADATA
# title: allow always
# description: allows automatically if not a destroy
allow[format2(rego.metadata.rule())]

format2(meta) := meta.description
