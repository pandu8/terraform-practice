//Resource
resource "aws_instance" "ec2-vpc" {
  ami = "ami-025fe52e1f2dc5044"
  key_name = "terraform-key"
  instance_type = "t2.micro"
  user_data = file("data.sh")
  tags = {
    Name = "userdata-ec2"
  }
}
