package env0

# METADATA
# title: (from engineering) require 1 approval
# description: (from engineering) At least 1 approvals must be given.
pending[format(rego.metadata.rule())] {
	count(input.approvers) < 1
}

# METADATA
# title: (from engineering) At least 1 approvals
# description: (from engineering) Only allow if one or more approvals are given.
allow[format(rego.metadata.rule())] {
	count(input.approvers) >= 1
}

format(meta) := meta.description
