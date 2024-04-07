resource "aws_sns_topic" "alarm_topic" {
  name = "alarm_topic"
}


output "sns_topic_arn" {
  value = aws_sns_topic.alarm_topic.arn
}