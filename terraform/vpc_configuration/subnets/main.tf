resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"  # Change to another AZ for high availability
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "PrivateSubnet1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"  # Change to another AZ for high availability

  tags = {
    Name = "PrivateSubnet2"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_subnet_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}


output "private_subnet_id" {
  value = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

output "public_subnet_id" {
  value = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}
