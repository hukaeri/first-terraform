terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }

  required_version = ">=0.13.0"

    backend "s3" {
      bucket = "tf-lxy-test"
      key    = "path/to/my/key"
      region = "eu-west-1"
      dynamodb_table = "terraform-state-locking-1"
      encrypt        = true
    }

}

provider "aws" {
  region     = "eu-west-1"
  profile = "tw-beach-lxy"
}