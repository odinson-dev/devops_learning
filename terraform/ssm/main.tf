resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = var.vpc_id  
  service_name      = "com.amazonaws.${var.aws_region}.ssm"  
  vpc_endpoint_type = "Interface"

  subnet_ids = var.subnet_ids  

  security_group_ids = var.ssm_sg_id  

  private_dns_enabled = true

  tags = {
    Name = "SSMEndpoint"
  }
}

resource "aws_vpc_endpoint" "ssm_messages" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.ssmmessages"  
  vpc_endpoint_type = "Interface"

  subnet_ids = var.subnet_ids

  security_group_ids = var.ssm_sg_id

  private_dns_enabled = true

  tags = {
    Name = "SSMMessagesEndpoint"
  }
}

resource "aws_vpc_endpoint" "ec2_messages" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.ec2messages" 
  vpc_endpoint_type = "Interface"

  subnet_ids = var.subnet_ids

  security_group_ids = var.ssm_sg_id

  private_dns_enabled = true

  tags = {
    Name = "EC2MessagesEndpoint"
  }
}
