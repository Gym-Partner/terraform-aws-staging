variable "aws_region" {
  type = string
  default = "us-east-1"
  description = "The default aws region"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "ami_arm64" {
  description = "Debian 12 ARM64 AMI for t4g.micro"
  default     = "ami-07c4edc673430f8b8"
}

variable "key_name" {
  type = string
  sensitive = true
  default = "SSH key name"
}

# variable "db_password" {
#   type        = string
#   sensitive   = true
#   description = "Mot de passe PostgreSQL"
# }

variable "aws_id" {
  type = string
  sensitive = true
}

variable "aws_secret" {
  type = string
  sensitive = true
}

# variable "rabbit_mq_username" {
#   type = string
#   sensitive = true
#   description = "Username for RabbitMQ broker"
# }
#
# variable "rabbit_mq_password" {
#   type = string
#   sensitive = true
#   description = "Password for RabbitMQ broker"
# }

variable "my_ip" {
  type = string
}