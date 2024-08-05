resource "aws_instance" "elb-ec2-1" {
  ami           = "ami-025fe52e1f2dc5044"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.sub1.id
  key_name = "terraform-key"
  vpc_security_group_ids = [aws_security_group.elb-sg.id]
  user_data = file("data1.sh")
  tags = {
    Name = "server1"
  }
}

resource "aws_instance" "elb-ec2-2" {
    ami           = "ami-025fe52e1f2dc5044"
    instance_type = "t2.micro"
    subnet_id     = aws_subnet.sub2.id
    key_name = "terraform-key"
    vpc_security_group_ids = [aws_security_group.elb-sg.id]
    user_data = file("data2.sh")
  tags = {
    Name = "server-2"
  }
}