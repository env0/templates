resource "null_resource" "dunno" {
  count = 3

}

output "test" {
  value     = 1
  sensitive = true
}
