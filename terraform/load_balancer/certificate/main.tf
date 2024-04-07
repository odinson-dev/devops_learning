resource "aws_acm_certificate" "my_cert" {
  private_key      = file("./test.example.com.key")
  certificate_body = file("./test.example.com.crt")
  # domain_name      = "test.example.com"
}


output "cert_arn" {
  value = aws_acm_certificate.my_cert.arn
}