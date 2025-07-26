variable "vpc_id" {
  type = string
}

variable "public_subnets_ids" {
  type = list(string)
}

variable "rabbit_mq_username" {
  type = string
}

variable "rabbit_mq_password" {
  type = string
}