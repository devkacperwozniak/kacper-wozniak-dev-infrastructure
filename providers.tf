terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }

  backend "s3" {
    bucket = "terraform-states-5455"
    key    = "kacper-wozniak-dev-infrastructure/terraform.tfstate"
    region = "eu-west-3"
  } 
}