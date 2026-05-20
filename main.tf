provider "aws" {
    region ="us-east-1"
}

#VPC
resource "aws_vpc" "main_vpc" {
    cidr_block =var.vpc_cidr
}

#subnet
resource "aws_subnet" "public_subnet"{
    vpc_id =aws_vpc.main_vpc.id
    cidr_block =var.subnet_cidr
    map_public_ip_on_launch = true
}

#Internet Gateway
resource "aws_internet_gateway" "igw"{
    vpc_id =aws_vpc.main_vpc.id
}

#route table
resource "aws_route_table" "rt"{
    vpc_id = aws_vpc.main_vpc.id
    route  {
        cidr_block ="0.0.0.0/0"
        gateway_id =aws_internet_gateway.igw.id
    }
}

#route table association
 resource "aws_route_table_association" "neeraj_rta" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.rt.id
 }

 #security group
 resource "aws_security_group" "neeraj_sg" {
    vpc_id = aws_vpc.main_vpc.id

    ingress {
        from_port =80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }   
    ingress {
        from_port =22
        to_port =22
        protocol ="tcp"
        cidr_blocks =["0.0.0.0/0"]
    }
    #allow outbound
    egress {
        from_port =0
        to_port =0
        protocol ="-1"
        cidr_blocks =["0.0.0.0/0"]
 }
 }
# EC2 instance
resource "aws_instance" "Neeraj_project1" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.neeraj_sg.id]
  key_name = var.key_name

  associate_public_ip_address = true
  user_data = <<-EOF
            #!/bin/bash
            apt update
            apt install -y nginx
            systemctl start nginx
            systemctl enable nginx
            EOF
}
