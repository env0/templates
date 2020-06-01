package terraform.library

# Rego utils to work with Terraform
# Copied from https://www.openpolicyagent.org/docs/latest/terraform/#working-with-modules

resources := { r |
  some path, value

  # Walk over the JSON tree and check if the node we are
  # currently on is a module (either root or child) resources
  # value.
  walk(input.planned_values, [path, value])

  # Look for resources in the current value based on path
  rs := module_resources(path, value)

  # Aggregate them into `resources`
  r := rs[_]
}

# Variant to match root_module resources
module_resources(path, value) = rs {

  # Expect something like:
  #
  #     {
  #     	"root_module": {
  #         	"resources": [...],
  #             ...
  #         }
  #         ...
  #     }
  #
  # Where the path is [..., "root_module", "resources"]

  reverse_index(path, 1) == "resources"
  reverse_index(path, 2) == "root_module"
  rs := value
}

# Variant to match child_modules resources
module_resources(path, value) = rs {

  # Expect something like:
  #
  #     {
  #     	...
  #         "child_modules": [
  #         	{
  #             	"resources": [...],
  #                 ...
  #             },
  #             ...
  #         ]
  #         ...
  #     }
  #
  # Where the path is [..., "child_modules", 0, "resources"]
  # Note that there will always be an index int between `child_modules`
  # and `resources`. We know that walk will only visit each one once,
  # so we shouldn't need to keep track of what the index is.

  reverse_index(path, 1) == "resources"
  reverse_index(path, 3) == "child_modules"
  rs := value
}

reverse_index(path, idx) = value {
	value := path[count(path) - idx]
}

list_contains_value(list, item) {
    list_item = list[_]
    list_item == item
}
