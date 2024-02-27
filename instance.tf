resource "aws_instance" "example" {
  ami           = "ami-0905a3c97561e0b69"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.main-public-1.id
}
