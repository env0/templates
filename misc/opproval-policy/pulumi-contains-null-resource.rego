package play

import rego.v1

# METADATA
# title: Check if contains null resource
# description: Contains null resource
allow[format(rego.metadata.rule())] if {
# 	count(input.plan.steps) >= 0
    contains(input.plan.steps[0].urn, "pulumi:Stack")
}

format(meta) := meta.description
