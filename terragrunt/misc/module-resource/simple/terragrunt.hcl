include {
  path = find_in_parent_folders()
}

generate "output" {
  path = "output.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF

output "find_IN_PARENT_folder" {
  value = "${find_in_parent_folders()}"
}
output "get_TG_dir" {
  value = "${get_terragrunt_dir()}"
}
output "get_ORIG_WORKDIR" {
  value = "${get_original_terragrunt_dir()}"
}
output "FROM" {
  value = "${get_path_from_repo_root()}"
}
output "TO" {
  value = "${get_path_to_repo_root()}"
}


EOF
}
