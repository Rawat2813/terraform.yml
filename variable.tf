variable "region" {
  description = "aws region"
  default     = "us-east-1a"
}
variable "vpc_cidr" {
  description = "CIDR block for vpc"
  default     = "10.0.0.0/16"
}
variable "subnet_cidr" {
  description = "CIDR block for public subnet"
  default     = "10.0.1.0/24"
}
variable "instance_type" {
  description = "ec2 instance type"
  default     = "t3.micro"
}

variable "ami" {
  description = "AMI id for ec2"
  default     = "ami-0ec10929233384c7f"
}
variable "key_name" {
  description = "Key pair name for SSH"
  default     = "" # optional
}
