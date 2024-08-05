terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket         = "devopsprojects-terraformstate"
    key            = "devops-projects/us-east-1/terraform.tfstate" #A path to store the terraform state file in the bucket
    region         = "us-east-1"
    profile = "devops-projects"
    dynamodb_table = "terraform-locks"
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

resource "aws_kms_key" "bucketkey" {
  description = "This key is used to encrypt the bucket data"
  deletion_window_in_days = 7
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "devopsprojects-terraformstate"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.bucketkey.arn
      sse_algorithm = "aws:kms"
    }
  }
}
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    id      = "Prevent Accidental Deletion"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 365
    }
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
    }
  }

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
