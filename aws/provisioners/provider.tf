terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.3.0"
    }
  }

  backend "s3" {
    bucket         = "aws-tf-remote-state-lock"
    key            = "provision-demo"
    region         = "us-east-1"
    dynamodb_table = "aws-state-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_key_pair" "ssh_pub_key" {
  key_name   = "terraform-provisioner-demo" # Replace with your desired key name
  public_key = file("~/.ssh/id_rsa.pem")    # Replace with the path to your public key file
}