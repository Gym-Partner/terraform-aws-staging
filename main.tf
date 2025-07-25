module "vpc" {
  source = "./vpc"
  aws_region = var.aws_region
  private_subnets_cidr = var.private_subnet_cidrs
  public_subnets_cidr = var.public_subnet_cidrs
  vpc_cidr = var.vpc_cidr
}

module "ec2" {
  source = "./ec2"
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  instance_type = var.instance_type
  key_name = var.key_name
}