###################
# VPC
###################

resource "aws_vpc" "this" {
  cidr_block                       = "192.168.0.0/16"
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name        = "${var.project}-${var.environment}-vpc"
    Project     = var.project
    Environment = var.environment
  }
}


###################
# Subnet
###################

resource "aws_subnet" "public_1a" {
  vpc_id                  = aws_vpc.this.id
  availability_zone       = "${var.region}a"
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project}-${var.environment}-public-subnet-1a"
    Project     = var.project
    Environment = var.environment
    Type        = "public"
  }
}

resource "aws_subnet" "private_3a" {
  vpc_id                  = aws_vpc.this.id
  availability_zone       = "${var.region}a"
  cidr_block              = "192.168.3.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.project}-${var.environment}-private-subnet-3a"
    Project     = var.project
    Environment = var.environment
    Type        = "private"
  }
}
resource "aws_subnet" "private_4c" {
  vpc_id                  = aws_vpc.this.id
  availability_zone       = "${var.region}c"
  cidr_block              = "192.168.4.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.project}-${var.environment}-private-subnet-4c"
    Project     = var.project
    Environment = var.environment
    Type        = "private"
  }
}


###################
# Route Table
###################

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project}-${var.environment}-public-route-table"
    Project     = var.project
    Environment = var.environment
    type        = "public"
  }
}
resource "aws_route_table_association" "public_1a" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_1a.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project}-${var.environment}-private-route-table"
    Project     = var.project
    Environment = var.environment
    type        = "private"
  }
}
resource "aws_route_table_association" "private_3a" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private_3a.id
}
resource "aws_route_table_association" "private_4c" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private_4c.id
}


###################
# Internet Gateway
###################

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project}-${var.environment}-internet-gateway"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_route" "public_rt_igw" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.this.id
  destination_cidr_block = "0.0.0.0/0"
}
