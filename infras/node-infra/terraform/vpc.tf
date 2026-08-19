##############################
# VPC
##############################

resource "aws_vpc" "node-infra-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}


##############################
# Private Subnets (one per AZ)
##############################
resource "aws_subnet" "private" {
  for_each = { for idx, az in var.availability_zones : az => idx }

  vpc_id            = aws_vpc.node-infra-vpc.id
  cidr_block        = var.private_subnet_cidrs[each.value]
  availability_zone = each.key

  tags = {
    Name = "${var.project_name}-private-${each.key}"
    Tier = "private"
  }
}

##############################
# Public Subnets (one per AZ)
##############################
resource "aws_subnet" "public" {
  for_each = { for idx, az in var.availability_zones : az => idx }

  vpc_id                  = aws_vpc.node-infra-vpc.id
  cidr_block              = var.public_subnet_cidrs[each.value]
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-${each.key}"
    Tier = "public"
  }
}


##############################
# Internet Gateway (for public subnets)
##############################
resource "aws_internet_gateway" "node-infra-igw" {
  vpc_id = aws_vpc.node-infra-vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

##############################
# Public Route Table -> Internet Gateway
##############################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.node-infra-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.node-infra-igw.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}