resource "aws_key_pair" "deployer" {
  key_name   = "sic-app-key"
  public_key = file("~/.keys/ec2-key.pub")
}

resource "aws_security_group" "allow_http" {
  description = "Allowing HTTP traffic"
  vpc_id      = aws_vpc.sic_vpc.id

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_http"
  }
}