package env0

# METADATA
# title: require 2 approvals
# description: At least 2 approvals must be given.
pending[format(rego.metadata.rule())] {
	count(input.approvers) < 2
}

# METADATA
# title: more than 2 approvals
# description: allow if two or more approvals are given.
allow[format(rego.metadata.rule())] {
	count(input.approvers) >= 2
}

format(meta) := meta.description
