resource "aws_instance" "count_base_demo" {
  count                  = var.instance_count
  ami                    = local.ami_id
  vpc_security_group_ids = aws_security_group.allow_tls[*].id
  instance_type          = local.instance_type
   key_name               = aws_key_pair.ssh_pub_key.key_name
  tags                   = {
    Name = "${var.environment}-demo-instance-${count.index}"
  }
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
  #name        = "allow_firewall"
  name_prefix = "allow_firewall_"  # AWS will append unique suffix
  description = "allowed inbound and outbound rules"
  
  count = length(var.inbound_ports)
  ingress {
    from_port   = var.inbound_ports[count.index]
    to_port     = var.inbound_ports[count.index]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = var.outbound_ports
    to_port     = var.outbound_ports
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = local.sg_name
  }
}

resource "aws_key_pair" "ssh_pub_key" {
  key_name   = "terraform-dynamic-blocks-demo"
  public_key = file(local.ssh_pub_key)
}
