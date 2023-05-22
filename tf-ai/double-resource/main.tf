resource "null_resource" "duplicate_name" {
  count = 2
}

resource "null_resource" "duplicate_name" {
  count = 1
}
