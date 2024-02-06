terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  profile = "devops-project"
  region  = "us-east-1"
}

module "aws-vpc" {
  source = "../modules/aws-vpc/"
  vpc_name = "DevOps-Project"

}
