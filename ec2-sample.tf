resource "aws_instance" "ec2" {
  ami = ""
  key_name = ""
  instance_type = ""
  tags = {
    Name        = "sample-ec2"
  }
}
