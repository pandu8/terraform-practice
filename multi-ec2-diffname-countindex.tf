resource "aws_instance" "ec2" {
  ami = "ami-0ad21ae1d0696ad58"
  key_name = "terraform-key"
  instance_type = "t2.micro"
  count = 3
  tags = {
    Name = "ec2-${count.index}"
  }
}
