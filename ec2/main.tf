# Security group pour l'EC2
resource "aws_security_group" "ec2_sg" {
  name   = "ec2-staging-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Spot t4g.micro
resource "aws_instance" "ec2_staging" {
  ami                    = var.ami_arm64
  instance_type          = "t4g.micro"
  subnet_id              = var.public_subnet_ids
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true
  key_name               = var.key_name

  instance_market_options {
    market_type = "spot"

    spot_options {
      instance_interruption_behavior = "terminate"
      max_price                      = "0.005"
    }
  }

  tags = {
    Name = "staging-api"
  }
}