resource "aws_vpc" "sic_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "sic-vpc"
  }
}

resource "aws_internet_gateway" "sic_igw" {
  vpc_id = aws_vpc.sic_vpc.id

  tags = {
    Name = "sic-igw"
  }
}

resource "aws_default_route_table" "sic-drt" {
  default_route_table_id = aws_vpc.sic_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sic_igw.id
  }

  tags = {
    Name = "sic-drt"
  }
}

resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.sic_vpc.id
  cidr_block              = "10.0.0.0/22"
  availability_zone       = "ap-southeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "sic-public-az1"
  }
}

resource "aws_subnet" "public_az2" {
  vpc_id                  = aws_vpc.sic_vpc.id
  cidr_block              = "10.0.4.0/22"
  availability_zone       = "ap-southeast-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "sic-public-az2"
  }
}

resource "aws_subnet" "public_az3" {
  vpc_id                  = aws_vpc.sic_vpc.id
  cidr_block              = "10.0.8.0/22"
  availability_zone       = "ap-southeast-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = "sic-public-az3"
  }
}

resource "aws_subnet" "private_az1" {
  vpc_id                  = aws_vpc.sic_vpc.id
  cidr_block              = "10.0.16.0/22"
  availability_zone       = "ap-southeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "sic-private-az1"
  }
}

resource "aws_subnet" "private_az2" {
  vpc_id                  = aws_vpc.sic_vpc.id
  cidr_block              = "10.0.20.0/22"
  availability_zone       = "ap-southeast-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "sic-private-az2"
  }
}

resource "aws_subnet" "private_az3" {
  vpc_id                  = aws_vpc.sic_vpc.id
  cidr_block              = "10.0.24.0/22"
  availability_zone       = "ap-southeast-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = "sic-private-az3"
  }
}