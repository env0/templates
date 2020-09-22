variable "vm_name" {
  type    = string
  description = "the name of the vm to spin up"
}

variable "http_server_port" {
  type    = number
  description = "the port to run the http server on"
}