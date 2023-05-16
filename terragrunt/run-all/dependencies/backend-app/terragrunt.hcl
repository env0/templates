include "temp" {
  path = "${dirname(find_in_parent_folders())}/__inputs/temp.hcl"
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}
