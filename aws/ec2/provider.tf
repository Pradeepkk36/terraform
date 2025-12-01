terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.3.0"
    }
  }

  backend "s3" {
    bucket         = "aws-tf-remote-state-lock"
    key            = "ec2-demo"
    region         = "us-east-1"
    dynamodb_table = "aws-state-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}


# # Generate SSH key pair (only once)
# resource "tls_private_key" "ssh_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# # Register the public key with AWS
# resource "aws_key_pair" "generated" {
#   key_name   = "terraform-generated-key"
#   public_key = tls_private_key.ssh_key.public_key_openssh
# }

# # Save the private key locally
# resource "local_file" "private_key" {
#   content  = tls_private_key.ssh_key.private_key_pem
#   directory_permission =  600
#   file_permission = 600
#   filename = "${path.module}/terraform-generated-key.pem"
# }