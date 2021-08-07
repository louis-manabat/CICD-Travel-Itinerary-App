resource "aws_vpc" "sic_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "sic-vpc"
  }
}

resource "aws_internet_gateway" "sic_igw" {
  vpc_id = aws_vpc.vpc.id

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