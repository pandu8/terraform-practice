output.tf
output "public_ip_addr" {
  value = aws_instance.ec2.example.public_ip
