variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2
}

variable "environment" {
  type        = string
  default     = "Dev"
  description = "Devoployment Environment(dev & prod)"
}

variable "inbound_ports" {
  type        = list(number)
  default     = [22, 80, 443]
  description = "inbound from and to ports"
}
variable "outbound_ports" {
  type        = number
  default     = 0
  description = "outbound from and to ports"
}

variable "common_tags" {
  type = map(any)
  default = {
    Name      = "ec2-Instance"
    Purpose   = "Terraform-Practices"
    component = "Sample-Instance"
  }
}

variable "ssh_key_path" {
  description = "Path to SSH public key"
  default     = "C:/Users/User/devops/ssh-key"
}

variable "domain_name" {
  default = "er-devops.space"
}

variable "host_zone_id" {
  default = "Z04820752CVWNI0DTZNQO"

}