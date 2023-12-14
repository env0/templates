resource "null_resource" "null" {
}

output "my complex output" {
  value = {
    foo = "bar"
    baz = "qux"
  }
}
