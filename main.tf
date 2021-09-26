terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  backend "s3" {
    bucket = "task09-cmba-s3bucket"
    key = "terraform_state/terraform.tfstate"
    region = "eu-central-1"
  }	
}

provider "aws" {
  profile = "default"
  region = "eu-central-1"
}

resource "aws_instance" "cmba_tfinstance" {
  ami = "ami-07df274a488ca9195"
  instance_type = "t2.micro"
  tags = {
    terraform = "managed"
    Name = "cmba_tfinstance"
  }
}

resource "aws_s3_bucket" "chizzy-bucket" {
  bucket = "cmba-tfbucket"
  versioning {
    enabled = true
  }
  tags = { 
    terraform = "managed"
  }
}

resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  users = [
    "some_user",
  ]

  group = "terraformlovers"
}


