output "instance_public_ip" {
  description = "Public IP of EC2"
  value       = aws_instance.Neeraj_project1.public_ip
}

output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "subnet_id" {
  value = aws_subnet.public_subnet.id
}