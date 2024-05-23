output "revision" {
  value = nonsensitive(local.revision)
}

output "repository" {
  value = nonsensitive(local.repository)
}

output "workspace_prefix" {
  value = var.workspace_prefix
}
