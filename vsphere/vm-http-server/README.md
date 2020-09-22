# VSphere
An example of creating a new VM over a given cluster, then SSHing to it and starting an http server.  

## Configuration

### Environment Variables
- `SSH_PASS` - the ssh password of the vm template
- `VMSPHERE_SERVER` - the vCenter server name for vSphere API operations  
- `VMSPHERE_USER` - the username for vSphere API operations  
- `VMSHPERE_PASSWORD` - the password for vSphere API operations
- `TF_VAR_http_server_port` - the port to run the http server on  

### Terraform Variables
- `vm_name` - the name of the vm to spin up
