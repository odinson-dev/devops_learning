variable "launch_template_id" {
  description = "Template ID"
  type        = string
}

variable "private_subnet_id" {
    type = set(string)
  
}

variable "public_subnet_id" {
    type = set(string)
  
}

variable "target_group_arn" {
  type = string
}
