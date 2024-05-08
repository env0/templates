resource "null_resource" "name" {
  count = 2
}

output "name" {
  value = "Shalom ani po"
}