locals {
  ami_id        = data.aws_ami.amazon_ami.id
  instance_type = var.environment == "prod" ? "t3.small" : "t3.micro"
  inbound_ports = [22, 80] # used for dynamic blocks parameter
  common_tags = {
    Name      = "${var.environment}-ec2-Instance"
    Purpose   = "Terraform-Practices"
    component = "Sample-Instance"
  }
  ssh_pub_key = "${var.ssh_key_path}/aws_ssh_key.pub"
  #ssh_pem_key = "C:/Users/User/devops/ssh-key/aws_ssh_key.pem"
}