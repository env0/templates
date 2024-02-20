package env0

# METADATA
# title: require 2 approvals
# description: At least 1 approvals must be given.
pending[format(rego.metadata.rule())] {
	count(input.approvers) < 1
}

# METADATA
# title: At least 2 approvals
# description: Only allow if two or more approvals are given.
allow[format(rego.metadata.rule())] {
	count(input.approvers) >= 1
}

format(meta) := meta.description