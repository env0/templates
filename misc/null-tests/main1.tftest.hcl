run "test" {
  assert {
    condition     = file(local_file.test.filename) == "Hesllo world!"
    error_message = "Incorrect content in ${local_file.test.filename}."
  }

  assert {
    condition     = alltrue([
      for v in var.instances : contains(["t2.micro", "m3.medium"], v.type)
    ])

    error_message = "my error message"
  }
}