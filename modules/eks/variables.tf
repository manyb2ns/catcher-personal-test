variable "project" {
  type        = string
  description = "Project Name"
}

variable "environment" {
  type        = string
  description = "Environment name like stg, prd"
}

variable "vpc_id" {
  type        = string
  description = "VPC id"
}

variable "pv_subnet_ids" {
  type        = list
  description = "Private subnet's ids"
}