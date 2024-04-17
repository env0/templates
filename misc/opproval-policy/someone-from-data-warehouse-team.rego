package env0

# METADATA
# title: At least 1 approval from data warehouse team
# description: At least 1 approvals from data warehouse team.
pending[format(rego.metadata.rule())] {
	count(input.approvers) < 1
}

# METADATA
# title: At least 1 approval from data warehouse team
# description: Only allow if one or more approvals from data warehouse team are given.
allow[format(rego.metadata.rule())] {
	count(input.approvers) >= 1
}

format(meta) := meta.description