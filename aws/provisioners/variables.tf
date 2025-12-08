variable "environment" {
  type        = string
  default     = "dev"
  description = "demo instance"
}

variable "common_tags" {
  type        = map(any)
  description = "map data type varibles"
  default = {
    Name      = "prov-ec2-Instance"
    Purpose   = "Terraform-Practices"
    component = "Sample-Instance"
  }
}