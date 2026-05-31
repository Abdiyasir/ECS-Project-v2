terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.46.0" # Updated to the newest available release
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}