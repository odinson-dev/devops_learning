variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = set(string)
}

variable "ssm_sg_id" {
  type = set(string)
}

variable "aws_region" {
  type = string
}