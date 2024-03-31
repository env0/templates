resource "null_resource" "dunno" {
  count = 3

}

output "non-sens" {
  value = 1
}

output "sens" {
  value     = "sensitive"
  sensitive = true
}
