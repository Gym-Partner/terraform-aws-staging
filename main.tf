module "vpc" {
  source = "./vpc"
  aws_region = var.aws_region
  private_subnets_cidr = var.private_subnet_cidrs
  public_subnets_cidr = var.public_subnet_cidrs
  vpc_cidr = var.vpc_cidr
}