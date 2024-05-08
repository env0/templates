resource "null_resource" "name" {
  count = 3
}

output "name" {
  value = "Shalom ani po"
}