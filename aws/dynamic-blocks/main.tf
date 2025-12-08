resource "aws_instance" "demo_instance" {
  ami                    = local.ami_id
  instance_type          = local.instance_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = aws_key_pair.ssh_pub_key.key_name
  tags                   = local.common_tags
  
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
      private_key = file("C:/Users/User/devops/ssh-key/aws_ssh_key.pem")
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
  name        = "${var.environment}-firewall"
  description = "allowed inbound and outbound rules"

  dynamic "ingress" {  # dynamic block used on inbound rules
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

resource "aws_key_pair" "ssh_pub_key" {
  key_name   = "terraform-dynamic-blocks-demo"
  public_key = file(local.ssh_pub_key)
}
