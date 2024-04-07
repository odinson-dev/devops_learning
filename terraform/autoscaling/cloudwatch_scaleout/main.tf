resource "aws_cloudwatch_metric_alarm" "scale_out_alarm" {
  alarm_name                = "HighCPUUtilization"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "70"
  alarm_description         = "This alarm triggers scale out when CPU exceeds 70%"
  actions_enabled           = true
  alarm_actions             = [var.scaleout_policy_arn]
  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }
}
