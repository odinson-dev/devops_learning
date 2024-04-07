resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "MyVPC"
  }
}

module "subnets" {
  source = "./subnets"
  vpc_id              = aws_vpc.main.id
  subnet_cidr_blocks  = ["10.0.1.0/24"]
  availability_zones = ["us-east1a"]
}

module "security_groups" {
  source = "./security_groups"

  vpc_id              = aws_vpc.main.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}


output "private_subnet_id" {
    value =  module.subnets.private_subnet_id
}

output "public_subnet_id" {
  value = module.subnets.public_subnet_id
}

output "lb_sg_id" {
  value = module.security_groups.lb_sg_id
}

output "instance_sg_id" {
  value = module.security_groups.instance_sg_id
}