data "aws_ami" "amazon_ami" { 
  most_recent = true  # this will enable the to pull the latest ami
  owners      = ["973714476881"]
  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
    # owners           = ["309956199498"]
    # filter {
    #     name   = "name"
    #     values = ["RHEL-10.0.0_HVM-20250918-x86_64-0-Hourly2-GP3"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_vpc" "default" {
  default = true
}
