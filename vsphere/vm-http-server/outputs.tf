output "vm_default_ip_address" {
  value = vsphere_virtual_machine.vm.default_ip_address
}

output "vm_http_server" {
  value = "http://${vsphere_virtual_machine.vm.default_ip_address}:${var.http_server_port}"
}