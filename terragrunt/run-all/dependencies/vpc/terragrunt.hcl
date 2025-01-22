include "temp" {
  path = "${dirname(find_in_parent_folders())}/__inputs/temp2.hcl"
}

terraform "Random" {
  source = "tfr://api-dev.dev.env0.com/bd12a04a-b051-4f51-9a8a-8a32ac198802/Random/env0?version=1.0.0"
}

