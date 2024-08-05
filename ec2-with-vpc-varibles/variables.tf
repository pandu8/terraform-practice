variable "ami" {
    default = "ami-0ad21ae1d0696ad58"  
}

variable "instance_type" {
    default = "t2.micro"
}

variable "key-name" {
    default = "terraform-key"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "subnet_cidr" {
    default = "10.0.0.0/24"
}
