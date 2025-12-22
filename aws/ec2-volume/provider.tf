terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.3.0"
    }
  }
  backend "s3" {
    bucket         = "aws-tf-remote-state-lock"
    key            = "ec2-vol"
    region         = "us-east-1"
    dynamodb_table = "aws-state-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}