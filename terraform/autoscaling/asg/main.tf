resource "aws_autoscaling_group" "my_asg" {
  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  min_size         = 1
  max_size         = 3
  desired_capacity = 2
  vpc_zone_identifier = [var.private_subnet_id]

  target_group_arns = [var.target_group_arn]
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.my_asg.name
  description = "The name of the Auto Scaling Group"
}