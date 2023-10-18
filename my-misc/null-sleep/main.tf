resource "time_sleep" "wait_30_seconds" {

  create_duration = "120s"
}

# This resource will create (at least) 30 seconds after null_resource.previous
resource "null_resource" "null" {
  depends_on = [time_sleep.wait_30_seconds]
}
