terraform {
    backend "s3" {
    bucket         	   = "url-shortener-state"
    key              	   = "prod/terraform.tfstate"
    region         	   = "eu-west-2"
    encrypt        	   = true
    dynamodb_table = "url-shortener-lock"
  }
}