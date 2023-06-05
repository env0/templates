include "temp" {
  path = "${dirname(find_in_parent_folders())}/__inputs/temp.hcl"
}

dependencies {
  paths = ["../vpc"]
}
