# VPC
resource "aws_vpc" "gym-partner-vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "gym-partner-vpc"
  }
}


# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.gym-partner-vpc.id

  tags = {
    Name = "gym-partner-igw"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count = 2
  vpc_id = aws_vpc.gym-partner-vpc.id
  cidr_block = var.public_subnets_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone = "${var.aws_region}${["a", "b"][count.index]}"

  tags = {
    Name = "public-subnet-${count.index}"
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count = 2
  vpc_id = aws_vpc.gym-partner-vpc.id
  cidr_block = var.private_subnets_cidr[count.index]
  availability_zone = "${var.aws_region}${["a", "b"][count.index]}"

  tags = {
    Name = "private-subnet-${count.index}"
  }
}

# NAT Gateway IP
resource "aws_eip" "nat" {
  domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public[0].id

  tags = {
    Name = "gym-partner-nat"
  }
}

# Route table - Public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.gym-partner-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  count = 2
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Route Table - Private
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.gym-partner-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private_assoc" {
  count = 2
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}