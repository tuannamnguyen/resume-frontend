terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.44.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_s3_bucket" "frontend_bucket" {
  bucket        = "tuannamnguyen-resume-frontend-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "fe_bucket_access_block" {
  bucket                  = aws_s3_bucket.frontend_bucket.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}
