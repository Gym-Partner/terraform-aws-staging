module "vpc" {
  source = "./vpc"
  aws_region = var.aws_region
}