resource "aws_instance" "provisioner_demo" {
  ami                    = local.ami_id
  instance_type          = local.instance_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = aws_key_pair.ssh_pub_key.key_name
  tags                   = local.tags

  provisioner "remote-exec" {
    inline = [
      #"sudo dnf update -y",
      "sudo dnf install -y nginx",
      "sudo systemctl start nginx",
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    when = destroy
    inline = [
      "sudo systemctl stop nginx",
    ]

  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "allowed inbound and outbound traffic"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  ingress {
    from_port = 80
    to_port   = 80
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
    name = local.sg_name
  }
}
