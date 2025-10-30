# variable "tags" {
#   default = {
#     CratedBy = "Terraform"
#     For      = "aws_skill_builder"
#   }
# }

variable "instance_alias" {
  default = "connect-dynamic-routing"
}

variable "log_retention" {
  type    = number
  default = 1
}
