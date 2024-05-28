package env0

# METADATA
# title: (from template) require 3 approvals
# description: (from template) At least 3 approvals must be given.
pending[format(rego.metadata.rule())] {
	count(input.approvers) < 3
}

# METADATA
# title: (from template) At least 3 approvals
# description: (from template) Only allow if three or more approvals are given.
allow[format(rego.metadata.rule())] {
	count(input.approvers) >= 3
}

format(meta) := meta.description
