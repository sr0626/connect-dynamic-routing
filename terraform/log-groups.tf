# CloudWatch Log Groups
resource "aws_cloudwatch_log_group" "ctr" {
  name              = "/aws/lambda/${var.instance_alias}-ctr"
  retention_in_days = var.log_retention
}

resource "aws_cloudwatch_log_group" "ae" {
  name              = "/aws/lambda/${var.instance_alias}-ae"
  retention_in_days = var.log_retention
}

resource "aws_cloudwatch_log_group" "ce" {
  name              = "/aws/lambda/${var.instance_alias}-ce"
  retention_in_days = var.log_retention
}