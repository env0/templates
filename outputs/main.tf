resource "null_resource" "dunno" {
  count = 3

}

output "number" {
  value = 1
}

output "bool" {
  value = true

}

output "str" {
  value = "lalala"
}

output "sens" {
  value     = "sensitive"
  sensitive = true
}

output "obj" {
  value = {
    key = "value"
  }

}

