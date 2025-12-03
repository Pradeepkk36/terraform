variable "environment" {
  type        = string
  description = "Devoployment Environment(dev & prod)"
  default     = "Dev"
}

variable "common_tags" {
  type        = map(any)
  description = "map data type varibles"
  default = {
    Name      = "Conditions-ec2-Instance"
    Purpose   = "Terraform-Practices"
    component = "Sample-Instance"
  }
}

variable "subnet_range" {
  type        = list(any)
  default     = ["0.0.0.0/0"]
  description = "subnet range of traffic allowed"
}

    