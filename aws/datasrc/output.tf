output "ami_id" {
  value = data.aws_ami.amazon_ami.id
}

output "default_vpc_id" {
  value = data.aws_vpc.default.id
}

output "sg_vpc_id" {
  value = aws_security_group.allow_tls.vpc_id
}

output "sg_id" {
  value = aws_security_group.allow_tls.id
}