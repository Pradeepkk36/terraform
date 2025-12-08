output "provisioner_demo" {
  value = aws_instance.provisioner_demo.id
}

output "ip_address" {
    value = aws_instance.provisioner_demo.public_ip
}