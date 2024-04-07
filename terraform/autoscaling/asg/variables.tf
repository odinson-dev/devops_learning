variable "launch_template_id" {
  description = "Template ID"
  type        = string
}

variable "private_subnet_id" {
    type = string
  
}

variable "public_subnet_id" {
    type = string
  
}

variable "target_group_arn" {
  type = string
}
