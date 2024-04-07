resource "aws_cloudwatch_metric_alarm" "scale_in_alarm" {
  alarm_name                = "LowCPUUtilization"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "30"
  alarm_description         = "This alarm triggers scale in when CPU drops below 30%"
  actions_enabled           = true
  alarm_actions             = [var.scalin_policy_arn]
  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }
}
