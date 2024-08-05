//creating VPC
resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
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
resource "aws_subnet" "sub1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "pub-sub1"
    }

}


// Creating Subnet
resource "aws_subnet" "sub2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-south-1b"
    tags = {
      Name = "pub-sub2"
    }

}
// Create a route table
resource "aws_route_table" "rt1" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IG.id
    }
    tags = {
      Name = "public-rt1"
    }
}

// Create a route table
resource "aws_route_table" "rt2" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IG.id
    }
    tags = {
      Name = "public-rt2"
    }
}
// Associate subnet with routetable
resource "aws_route_table_association" "a1" {
    subnet_id = aws_subnet.sub1.id
    route_table_id = aws_route_table.rt1.id

}
resource "aws_route_table_association" "a2" {
    subnet_id = aws_subnet.sub2.id
    route_table_id = aws_route_table.rt2.id

}
