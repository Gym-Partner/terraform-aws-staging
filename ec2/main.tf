resource "aws_security_group" "api-sg" {
  name = "api-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
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

resource "aws_instance" "api" {
  ami = "ami-0779caf41f9ba54f0"
  instance_type = var.instance_type
  subnet_id = var.public_subnet_ids[0]
  associate_public_ip_address = true
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.api-sg.id]

  tags = {
    Name = "ec2-api"
  }
}