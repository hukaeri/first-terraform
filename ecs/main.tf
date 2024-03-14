terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">=0.13.0"
}

provider "aws" {
  profile = "tw-beach-lxy"
  region  = "eu-west-1"
}