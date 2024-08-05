//creating VPC
resource "aws_vpc" "myvpc" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = "myvpc"
    }
  
}

//Creating Internet Gateway 
resource "aws_internet_gateway" "IG" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
      Name = "my-IG"
    }
}

// Creating Subnet 
resource "aws_subnet" "sub" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = var.subnet_cidr
    map_public_ip_on_launch = "true"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "pub-sub"
    }
  
}

// Create a route table 
resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IG.id
    }
    tags = {
      Name = "public-rt"
    }
}

// Associate subnet with routetable 
resource "aws_route_table_association" "a1" {
    subnet_id = aws_subnet.sub.id
    route_table_id = aws_route_table.rt.id
  
}

//Resource
resource "aws_instance" "ec2" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key-name
   vpc_security_group_ids = [aws_security_group.sg.id]
   subnet_id = aws_subnet.sub.id
   tags = {
     Name = "my-ec2"
   }
}

//SG
resource "aws_security_group" "sg" {
    name = "sg"
    vpc_id = aws_vpc.myvpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "my-sg"

    }

}
