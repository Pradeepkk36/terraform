output "instance_id" {
  value = aws_instance.count_base_demo[*].id
}

output "public_ip" {
  value = aws_instance.count_base_demo[*].public_ip
}