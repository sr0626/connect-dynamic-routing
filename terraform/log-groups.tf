# CloudWatch Log Groups
resource "aws_cloudwatch_log_group" "ctr" {
  name              = "/aws/lambda/${var.instance_alias}-ctr"
  retention_in_days = var.log_retention
  kms_key_id        = aws_kms_key.test.arn
}

resource "aws_cloudwatch_log_group" "ae" {
  name              = "/aws/lambda/${var.instance_alias}-ae"
  retention_in_days = var.log_retention
  kms_key_id        = aws_kms_key.test.arn
}

resource "aws_cloudwatch_log_group" "ce" {
  name              = "/aws/lambda/${var.instance_alias}-ce"
  retention_in_days = var.log_retention
  kms_key_id        = aws_kms_key.test.arn
}

resource "aws_cloudwatch_log_group" "dynamic_router" {
  name              = "/aws/lambda/${var.instance_alias}-dynamic-router"
  retention_in_days = var.log_retention
  kms_key_id        = aws_kms_key.test.arn
}

# resource "aws_cloudwatch_log_group" "connect_instance_log_group" {
#   name              = "/aws/lambda/${var.instance_alias}"
#   retention_in_days = var.log_retention
#   #kms_key_id        = aws_kms_key.test.arn
# }