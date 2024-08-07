resource "aws_instance" "ec2_example" {
    ami = "ami-0ad21ae1d0696ad58"  
    instance_type = "t2.micro" 
    key_name= "vasu-key"
    vpc_security_group_ids = [aws_security_group.main.id]
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}


resource "aws_key_pair" "deployer" {
  key_name   = "vasu-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKajt6k+rPlTbsTwNWeZwOy9f02N3ijgfaIWZkJE4EOp"
}
