resource "aws_instance" "ec2-volume" {
  ami                    = local.ami # ubuntu ami used
  instance_type          = local.instance_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = local.key_name
  tags                   = local.common_tags
  root_block_device {
    volume_size           = 25    # The size of the volume in GiB
    volume_type           = "gp2" # The volume type (e.g., gp2, gp3, io1, etc.)
    delete_on_termination = true  # Whether the volume should be deleted on instance termination
    # encrypted             = true  # Enable volume encryption
  }

  ebs_block_device {
    device_name           = "/dev/sdf" # The device name to mount in the OS
    volume_size           = 10         # Sets the additional volume size to 100 GiB
    volume_type           = "gp3"
    delete_on_termination = true # Optional: deletes the volume when the instance is terminated
  }

}

resource "aws_key_pair" "ssh_key" {
  key_name   = "terraform-ec2-volume-demo"
  public_key = file(local.ssh_pub_key)
}


resource "aws_security_group" "allow_tls" {
  name        = "${var.environment}-firewall"
  description = "allowed inbound and outbound rules"

  dynamic "ingress" { # dynamic block used on inbound rules
    for_each = local.inbound_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = var.outbound_ports
    to_port     = var.outbound_ports
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-firewall-allowed"
  }
}