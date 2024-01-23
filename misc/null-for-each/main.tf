resource "null_resource" "null2" {
  for_each = toset(["aaa.yarivvvvvvvvvvvvvvvv.trying.to.do.a.very.long.resource.maybe.it.will.reproduce", "ccc"])
}

locals {
  files = {
    "file1.txt" = "Content for file 1",
    "file2.txt" = "Content for file 2",
    "file3.txt" = "Content for file 3"
  }
}

resource "local_file" "example" {
  for_each = local.files
  filename = each.key
  content  = each.value
}