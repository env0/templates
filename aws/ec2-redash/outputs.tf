output "tls_private_key" {
  value = tls_private_key.private_key.private_key_pem
  description = "The private key to be used in order to ssh to the ec2 instance"
  sensitive = true
}

output "instance_public_ip" {
  value = aws_eip.redash-elastic-ip.public_ip
  description = "The public IP of your Redash instance"
}

