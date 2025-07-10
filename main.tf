output "instance_ip_addr" {
  value       = "Tomer" 
  description = "The private IP address of the main server instance."
  sensitive = true
}

resource "null_resource" "n" {

}

