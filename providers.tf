terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  access_key = var.aws_id
  secret_key = var.aws_secret

  default_tags {
    tags = {
      Environnement = "staging"
      Project = "gym-partner"
    }
  }
}