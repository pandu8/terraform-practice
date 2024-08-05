resource "aws_instance" "my-ec2" {
    ami = "ami-001843b876406202a"
    instance_type = "t2.micro"
    key_name = "login-key"
    count = 3
    tags = {
        Name = "terra-ec2"
    }
  
}
