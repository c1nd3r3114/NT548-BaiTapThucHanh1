terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.30.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" # Replace with your preferred AWS region
}
