resource "aws_autoscaling_policy" "scale_in" {
  name                   = "scale-in"
  autoscaling_group_name = var.autoscaling_group_name
  policy_type            = "TargetTrackingScaling"
  estimated_instance_warmup = 300

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 40.0
  }
}


output "scale_in_arn" {
  value = aws_autoscaling_policy.scale_in.arn
}