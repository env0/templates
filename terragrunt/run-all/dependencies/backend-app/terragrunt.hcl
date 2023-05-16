include "temp" {
  path = "${dirname(find_in_parent_folders())}/__inputs/temp.hcl"
}

dependency "vpc" {
  config_path = "../vpc"
}

output "test" {
  value = dependency.vpc.outputs.vpc_id
}
