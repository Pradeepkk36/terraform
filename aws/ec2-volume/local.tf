locals {
  ami           = data.aws_ami.ami.id
  ssh_pub_key   = "C:/Users/User/devops/ssh-key/aws_ssh_key.pub"
  key_name      = aws_key_pair.ssh_key.key_name
  instance_type = var.environment == "prod" ? "t3.small" : "t3.micro"
  inbound_ports = [22, 80] # used for dynamic blocks parameter
  common_tags = {
    Name      = "${var.environment}-ec2-Instance"
    Purpose   = "Terraform-Practices"
    component = "Sample-Instance"
  }
}