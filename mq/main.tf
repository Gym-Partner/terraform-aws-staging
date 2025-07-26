resource "aws_mq_broker" "rabbitmq_broker" {
  broker_name        = "rabbitmq-broker"
  engine_type        = "RabbitMQ"
  engine_version     = "3.11.20"
  host_instance_type = "mq.t3.micro"
  deployment_mode = "SINGLE_INSTANCE"
  subnet_ids = var.public_subnets_ids
  publicly_accessible = false
  configuration {
    id = ""
    revision = ""
  }
  user {
    password = var.rabbit_mq_password
    username = var.rabbit_mq_username
  }

  auto_minor_version_upgrade = true
  maintenance_window_start_time {
    day_of_week = "MONDAY"
    time_of_day = "18:00"
    time_zone   = "UTC"
  }

  apply_immediately = true
}