locals {
  instance_name = "${terraform.workspace}-instance" 
}

resource "aws_instance" "ec2_workspace" {

    ami = "ami-09d8b83b58eabf58b" 
    instance_type = var.instance_type

    tags = {
      Name = local.instance_name
    }
}
