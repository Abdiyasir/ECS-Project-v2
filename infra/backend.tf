terraform {
    backend "s3" {
    bucket         	   = "url-s3-156165"
    key              	   = "prod/terraform.tfstate"
    region         	   = "eu-west-2"
    encrypt        	   = true
    use_lockfile       = true
  }
}