package play

# METADATA
# title: (from engineering) require 1 approval
# description: (from engineering) At least 1 approvals must be given.
pending[format(rego.metadata.rule())] {
	count(input.approvers) < 1
}

# METADATA
# title: Check if contains null resource
# description: Contains null resource
allow[format(rego.metadata.rule())] {
    contains(input.plan.steps[0].urn, "pulumi:Stack")
}

format(meta) := meta.description
