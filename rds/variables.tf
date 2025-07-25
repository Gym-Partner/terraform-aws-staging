variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "db_username" {
  default = "postgres"
}

variable "db_password" {
  sensitive = true
}
variable "microservices_sg_id" {
  description = "Security group ID from EC2 to allow connection"
  type        = string
}