resource "null_resource" "my_resource" {
  triggers = {
    my_value = "test1"
    count = 3
  }
}

output "my_value" {
  value = null_resource.my_resource.triggers.my_value
}

output "my_count" {
  value = null_resource.my_resource.triggers.count
}
