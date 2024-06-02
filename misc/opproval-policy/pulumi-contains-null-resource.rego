package play

# METADATA
# title: Check if contains null resource
# description: Contains null resource
allow[format(rego.metadata.rule())] {
    contains(input.plan.steps[0].urn, "pulumi:Stack")
}

format(meta) := meta.description
