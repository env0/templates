package env0

# METADATA
# title: (from dynamoDb) require 2 approvals
# description: (from dynamoDb) At least 2 approvals must be given.
pending[format(rego.metadata.rule())] {
	count(input.approvers) < 2
}

# METADATA
# title: (from dynamoDb) At least 2 approvals
# description: (from dynamoDb) Only allow if two or more approvals are given.
allow[format(rego.metadata.rule())] {
	count(input.approvers) >= 2
}

format(meta) := meta.description
