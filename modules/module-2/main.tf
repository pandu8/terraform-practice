resource "aws_instance" "ec2_module_2" {

    ami = "ami-0a4408457f9a03be3"
    instance_type = "t2.micro"
    key_name= "terraform-key"
    vpc_security_group_ids = [aws_security_group.main.id]
    tags = {
      Name = "module-2"
    }
     user_data = <<-EOF
      #!/bin/sh
      sudo yum update -y
      sudo yum install nginx -y
      sudo systemctl start nginx
      EOF

}
resource "aws_security_group" "main" {
  name        = "m2-SG-2"
  description = "Webserver for EC2 Instances"

  ingress {
    from_port   = 80
    protocol    = "TCP"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = ["115.97.103.44/32"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
