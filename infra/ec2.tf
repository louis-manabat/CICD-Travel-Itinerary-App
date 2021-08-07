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

resource "aws_security_group" "allow_ssh" {
  description = "Allowing SSH traffic"
  vpc_id      = aws_vpc.sic_vpc.id

  ingress {
    description = "SSH from internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allowing port 5000"
    from_port   = 5000
    to_port     = 5000
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
    Name = "allow_ssh"
  }
}

resource "aws_lb" "sic_app_lb" {
  name                       = "sic-app-lb"
  internal                   = false
  load_balancer_type         = "application"
  enable_deletion_protection = false
  security_groups            = [aws_security_group.allow_http.id]
  subnets                    = [aws_subnet.public_az1, aws_subnet.public_az2, aws_subnet.public_az3]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "sic_app_lb_tg" {
  name     = "sic-app-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.sic_vpc.id
}

resource "aws_lb_listener" "sic_app_lb_listener" {
  load_balancer_arn = aws_lb.sic_app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sic_app_lb_tg.arn
  }
}

resource "aws_instance" "sic_app_ec2" {
  ami                         = data.aws_ami.ubuntu_lts.image_id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private_az1.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.deployer.key_name
  security_groups             = [aws_security_group.allow_ssh.id]
  count                       = 1

  tags = {
    Name = "SIC-App"
  }
}

resource "aws_lb_target_group_attachment" "sic_app_lb_tg_attachment" {
  target_group_arn = aws_lb_target_group.sic_app_lb_tg.arn
  target_id        = aws_instance.sic_app_ec2[0].id
}