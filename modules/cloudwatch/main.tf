variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "db_instance_identifier" {
  description = "The identifier of the RDS instance"
  type        = string
}

variable "sns_topic_arn" {
  description = "The ARN of the SNS topic"
  type        = string
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 14
}

resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  alarm_name                = "LambdaErrorsAlarm"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = "Errors"
  namespace                 = "AWS/Lambda"
  period                    = "60"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "Alarm if lambda errors exceed 1 in 1 minute"
  dimensions = {
    FunctionName = var.lambda_function_name
  }

  alarm_actions = [var.sns_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "lambda_latency" {
  alarm_name                = "LambdaLatencyAlarm"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = "Duration"
  namespace                 = "AWS/Lambda"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "1000"
  alarm_description         = "Alarm if lambda duration exceeds 1000ms in 1 minute"
  dimensions = {
    FunctionName = var.lambda_function_name
  }

  alarm_actions = [var.sns_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu_utilization" {
  alarm_name                = "RDSCPUUtilizationAlarm"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "Alarm if RDS CPU utilization exceeds 80% in 1 minute"
  dimensions = {
    DBInstanceIdentifier = var.db_instance_identifier
  }

  alarm_actions = [var.sns_topic_arn]
}
