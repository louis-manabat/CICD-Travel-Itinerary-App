data "aws_ami" "ubuntu_lts" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["Ubuntu Server 18.04 LTS*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}