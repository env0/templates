resource "null_resource" "name" {
  count = 5
}

output "name" {
  value = "Shalom ani po"
}