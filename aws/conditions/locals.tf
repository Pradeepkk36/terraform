locals {
  ami_id        = data.aws_ami.ami_rhel.id
  instance_type = var.environment == "prod" ? "t3.small" : "t3.micro"
  tags = merge(
    var.common_tags,
    {
      Name = var.environment == "prod" ? "prod-${var.common_tags.Name}" : "dev-${var.common_tags.Name}"
    }
  )
  sg_name = "network-opened-${var.environment}"
}