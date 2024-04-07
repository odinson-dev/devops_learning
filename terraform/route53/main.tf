resource "aws_route53_zone" "private_zone" {
  name          = "example.com"
  vpc {
    vpc_id = var.vpc_id
  }
}

resource "aws_route53_record" "test_record" {
  zone_id = aws_route53_zone.private_zone.id
  name    = "test.example.com"
  type    = "CNAME"
  ttl     = "300"
  records = [var.alb_dns_name]
}

