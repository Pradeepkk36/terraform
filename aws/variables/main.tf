resource "aws_instance" "ec2_var_demo" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags                   = var.common_tags
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "allow TLS inbound and outbound rules"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  tags = {
    Name = "allow tls"
  }
}