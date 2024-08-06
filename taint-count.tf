//count-index
resource "aws_instance" "my_vm" {
ami           = "ami-025fe52e1f2dc5044"
instance_type = "t2.micro"
key_name = "terraform-key"
count = 3
tags = {
   Name = format("vasu_%d", count.index)
}
}
//use below command in termibal to taint specific machine 
//terraform taint "aws_instance.my_vm[0]"

//foreach-toset
data "aws_ami" "ubuntu" {
 most_recent = true


 filter {
   name   = "name"
   values = ["ubuntu*"]
 }
}




locals {
 instances = {
   instance1 = {
     ami           = data.aws_ami.ubuntu.id
     instance_type = "t3.micro"
   }
   instance2 = {
     ami           = data.aws_ami.ubuntu.id
     instance_type = "t3.micro"
   }
   instance3 = {
     ami           = data.aws_ami.ubuntu.id
     instance_type = "t2.medium"
   }
 }
}


resource "aws_instance" "my_vm" {
 for_each      = local.instances
 ami           = each.value.ami
 instance_type = each.value.instance_type


 tags = {
   Name = format("VM_%s", each.key)
 }
}

//use below command in termibal to taint specific machine 
//