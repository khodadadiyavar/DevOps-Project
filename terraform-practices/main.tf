terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

  required_version = ">= 1.9.0"
}

provider "aws" {
  profile = "devops-projects"
  region  = "us-east-1"
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_instance" "ec2-instance-1" {
  ami           = "ami-03972092c42e8c0ca"
  instance_type = "t2.micro"
  tags = {
    Name = "remote-backend-lab"
  }
}
