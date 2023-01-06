terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.10"
    }
  }

  required_version = ">= 1.1.0"
}

provider "aws" {
  region = "us-east-2"
}