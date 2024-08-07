resource "aws_instance" "ec2_module_1" {

    ami = "ami-0ad21ae1d0696ad58"
    instance_type = "t2.micro"
    key_name= "terraform-key"
    vpc_security_group_ids = [aws_security_group.main.id]
    user_data = <<-EOF
      #!/bin/sh
      sudo apt-get update
      sudo apt install -y apache2
      sudo systemctl status apache2
      sudo systemctl start apache2
      sudo chown -R $USER:$USER /var/www/html
      sudo echo "<html><body><h1>Hello this is module-1 at instance id `curl http://169.254.169.254/latest/meta-data/instance-id` </h1></body></html>" > /var/www/html/index.html
      EOF
    tags = {
      Name = "module-1"
    }
}

resource "aws_security_group" "main" {
    name        = "m1-SG-1"
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
