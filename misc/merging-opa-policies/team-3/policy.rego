package env0

# METADATA
# title: require 2 approvals
# description: From team 3 At least 4 approvals must be given.
pending[format(rego.metadata.rule())] {
	count(input.approvers) < 4
}

# METADATA
# title: At least 3 approvals
# description: From team 3 Only allow if four or more approvals are given.
allow[format(rego.metadata.rule())] {
	count(input.approvers) >= 4
}

format(meta) := meta.description