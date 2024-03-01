resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main-public-1" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "eu-west-1a"
  cidr_block        = "10.0.0.0/16"
}

resource "aws_instance" "foo" {
  instance_type = "abc"
}