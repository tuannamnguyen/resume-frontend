terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.44.0"
    }
    namecheap = {
      source  = "namecheap/namecheap"
      version = "2.1.2"
    }
  }



  backend "s3" {
    region = "ap-southeast-1"
    bucket = "nguyentuannamcv-fe-terraform-state"
    key    = "terraform.tfstate"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"

}
