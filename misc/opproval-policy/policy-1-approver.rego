package env0

# METADATA
# title: require 1 approval
# description: At least 1 approvals must be given.
pending[format(rego.metadata.rule())] {
	count(input.approvers) < 1
}

# METADATA
# title: At least 1 approvals
# description: Only allow if one or more approvals are given.
allow[format(rego.metadata.rule())] {
	count(input.approvers) >= 1
}

format(meta) := meta.description