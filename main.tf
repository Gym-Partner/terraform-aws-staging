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
  public_subnet_ids = module.vpc.public_subnet_id
  instance_type = var.instance_type
  key_name = var.key_name
  ami_arm64 = var.ami_arm64
  my_ip = var.my_ip
}

module "cognito" {
  source = "./cognito"
}

# module "rds" {
#   source = "./rds"
#   db_password = var.db_password
#   microservices_sg_id = module.ec2.api_sg_id
#   private_subnet_ids = module.vpc.private_subnet_ids
#   public_subnet_ids = module.vpc.public_subnet_ids
#   vpc_id = module.vpc.vpc_id
# }

# module "mq" {
#   source = "./mq"
#   vpc_id = module.vpc.vpc_id
#   public_subnets_ids = module.vpc.public_subnet_ids
#   rabbit_mq_password = var.rabbit_mq_password
#   rabbit_mq_username = var.rabbit_mq_username
# }