//Template
resource "aws_launch_configuration" "launch_config" {
  name          = "my-template"
  image_id      = "ami-0ad21ae1d0696ad58"
  instance_type = "t2.micro"
  key_name      = "terraform-key"
  security_groups = [var.security_group_id]
}

//Asg
resource "aws_autoscaling_group" "example_autoscaling" {
  name                      = "autoscaling-terraform-test"
  max_size                  = 3
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.launch_config.name
  availability_zones        = ["ap-south-1a","ap-south-1b"]

}

variable "security_group_id" {
  type    = string
  default = "sg-0fe09d672587cf939"
}


