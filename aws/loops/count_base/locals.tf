locals {
  ami_id        = data.aws_ami.amazon_ami.id
  instance_type = var.environment == "prod" ? "t3.small" : "t3.micro"
  sg_name       = "${var.environment}-firewall-rule"
  ssh_pub_key   = "${var.ssh_key_path}/aws_ssh_key.pub"
}