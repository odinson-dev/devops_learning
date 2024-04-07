resource "aws_lb" "my_alb" {
  name               = "my-application-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = var.public_subnet_id

  enable_deletion_protection = false

  tags = {
    Name = "myALB"
  }
}


output "alb_dns_name" {
  value = aws_lb.my_alb.dns_name
}

output "alb_arn" {
  value = aws_lb.my_alb.arn
}