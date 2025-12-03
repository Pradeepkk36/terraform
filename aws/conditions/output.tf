output "ec2_id" {
  value = aws_instance.cond_demo.id
}

output "vpc_id" {
  value = aws_security_group.allow_tls.id
}

output "sg_vpc_id" {
  value = aws_security_group.allow_tls.vpc_id
}