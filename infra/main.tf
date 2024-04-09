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
  bucket        = "resume-frontend-bucket"
  force_destroy = true
}
