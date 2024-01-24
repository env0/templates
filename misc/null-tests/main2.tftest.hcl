run "test1" {
  assert {
    condition     = file(local_file.test.filename) == "Hello world!"
    error_message = "Incorrect content in ${local_file.test.filename}."
  }
}


run "test2" {
  assert {
    condition     = null_resource.hever[3].triggers.test == "hessver1"
    error_message = "Incorrect content in ${local_file.test.filename}."
  }
}