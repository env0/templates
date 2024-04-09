package env0

# METADATA
# title: require approvals
# description: From team 2 At least 3 approvals must be given.
pending[format(rego.metadata.rule())] {
	count(input.approvers) < 3
}

# METADATA
# title: At least approvals
# description: From team 2 Only allow if two or more approvals are given.
allow[format(rego.metadata.rule())] {
	count(input.approvers) >= 3
}

format(meta) := meta.description