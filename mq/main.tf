resource "aws_security_group" "rabbitmq_sg" {
  name = "rabbit-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 5672
    to_port = 5672
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_mq_broker" "rabbitmq_broker" {
  broker_name        = "rabbitmq-broker"
  engine_type        = "RabbitMQ"
  engine_version     = "3.13"
  host_instance_type = "mq.t3.micro"
  deployment_mode = "SINGLE_INSTANCE"

  subnet_ids = [var.public_subnets_ids[0]]
  security_groups = [aws_security_group.rabbitmq_sg.id]
  publicly_accessible = false

  configuration {
    id = aws_mq_configuration.rabbitmq_broker_config.id
    revision = aws_mq_configuration.rabbitmq_broker_config.latest_revision
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

resource "aws_mq_configuration" "rabbitmq_broker_config" {
  engine_type    = "RabbitMQ"
  engine_version = "3.13"
  name           = "rabbitmq-broker"
  description = "RabbitMQ config"
  data = <<DATA
# Default RabbitMQ delivery acknowledgement timeout is 30 minutes in milliseconds
consumer_timeout = 1800000
DATA
}