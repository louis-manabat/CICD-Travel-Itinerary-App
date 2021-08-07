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