resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "SSMInstanceProfile"
  role = var.iam_role
}

output "iam_instance_profile" {
  value = aws_iam_instance_profile.ssm_instance_profile.name
}