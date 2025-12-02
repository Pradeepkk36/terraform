# variable "ami_id" {
#   type        = string
#   default     = "ami-09c813fb71547fc4f"
#   description = "devops practices RHEL ami used"
# }

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "default type of instance"
}

variable "common_tags" {
  type = map(any)
  default = {
    Name    = "datasource_demo"
    Purpose = "terraform_practices"
  }
}