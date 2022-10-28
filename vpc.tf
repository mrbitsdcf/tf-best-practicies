resource "aws_vpc" "vpc" {
  cidr_block       = "10.20.30.0/24"

  tags = {
    Name = "vpc-tf-best-practices"
  }
}
