variable "instance" {
  type        = string
  description = "type of an instance"
  default     = "t3.micro"
}

variable "environment" {
  type        = string
  description = "default environment dev"
  default     = "dev"
}

variable "outbound_ports" {
  type    = number
  default = 0
}