resource "aws_instance" "cond_demo" {
  ami             = local.ami_id
  instance_type   = local.instance_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = local.tags
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "allow inbound and outbound rule"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.subnet_range
  }

  ingress {
    from_port = 8080
    to_port =  8080
    protocol = "tcp"
    cidr_blocks = var.subnet_range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.subnet_range
  }

  tags = {
    Name = local.sg_name
  }
}