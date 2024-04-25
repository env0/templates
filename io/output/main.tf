resource "null_resource" "name" {
  count = 1
}

output "name" {
  value = "I should print this!"
}