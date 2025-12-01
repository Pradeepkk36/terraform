#string type variables
variable "ami_id" {
  type    = string
  default = "ami-09c813fb71547fc4f"
  description = "default ami used to create a demo instance"
}

variable "instance_type" { 
  type    = string 
  default = "t3.micro"
  description = "default demo instance type"
}

# map type varibles
variable "common_tags" {  
  type = map(any)
  default = {
    Name    = "demo_instance_var"
    Purpose = "terraform_practices"
  }
}

#number type variables
variable "ingress_from_port" {
    type = number
    default = 22
    description = "allowed ssh port for ingress"
}

variable "ingress_to_port" {
    type = number 
    default = 22
    description = "allowed ssh port for ingress"
}

#list type variables
variable "cidr_blocks" {
    type = list
    default = [
      "0.0.0.0/0",
    ]
    description = "allow subnet range to access the demo ec2"
}