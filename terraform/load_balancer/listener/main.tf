resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = var.my_alb_arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.my_cert_arn

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}
