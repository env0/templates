resource "time_sleep" "wait_30_seconds" {
  create_duration = "8s"
}

resource "null_resource" "null" {
  depends_on = [time_sleep.wait_30_seconds]
}
