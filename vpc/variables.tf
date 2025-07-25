variable "aws_region" {
  type = string
}

variable "vpc_cidr" {
  type = string
  description = "CIDR bloc for VPC"
}

variable "public_subnets_cidr" {
  type = list(string)
  description = "CIDR bloc for public subnet VPC"
}

variable "private_subnets_cidr" {
  type = list(string)
  description = "CIDR bloc for private subnet VPC"
}