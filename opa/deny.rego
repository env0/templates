package env0

# METADATA
# title: deny destroys
# description: destroys are not allowed in this project
deny[format(rego.metadata.rule())] {
	input.deploymentRequest.type == "destroy"
}

format(meta) := meta.description
