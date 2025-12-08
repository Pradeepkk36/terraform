variable "environment" {
  type        = string
  description = "default environment dev"
  default     = "dev"
}

variable "outbound_ports" {
  type    = number
  default = 0
}

# variable "ssh_public_key_path" {
#   description = "Path to SSH public key"
#   default     = "C:/Users/User/devops/ssh-key/aws_ssh_key.pub"
# }

variable "ssh_key_path" {
  description = "Path to SSH public key"
  default     = "C:/Users/User/devops/ssh-key"
}