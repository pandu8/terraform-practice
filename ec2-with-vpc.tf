//VPC creation
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "myvpc"
  }
}

//Internet Gateway Creation
resource "aws_internet_gateway" "my-IG" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
      Name = "my-IG"
    }
}

//subnets creation
resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "pub-sub"
  }
}

resource "aws_subnet" "sub2" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "pri-sub"
  }
}

//Route table creation
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-IG.id
  }
  tags = {
    Name = "pub-rt"
  }
}

resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "pri-rt"
  }
}

//Subnet association
resource "aws_route_table_association" "pub" {
  subnet_id = aws_subnet.sub1.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_route_table_association" "pri" {
  subnet_id = aws_subnet.sub2.id
  route_table_id = aws_route_table.rt2.id
}

//security group
resource "aws_security_group" "SG" {
  name = "SG"
  description = "allow TLS inbpound traffic"
  vpc_id = aws_vpc.myvpc.id
  ingress {
    description = "TLS form VPC"
    from_port = 22
    to_port = 22
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

//Resource
resource "aws_instance" "ec2-vpc" {
  ami = "ami-0ad21ae1d0696ad58"
  key_name = "terraform-key"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.sub1.id
  vpc_security_group_ids = [aws_security_group.SG.id]
  tags = {
    Name = "ec2-vpc"
  }
}
