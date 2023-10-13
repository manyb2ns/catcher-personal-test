variable "project" {
  type        = string
  description = "Project Name"
}

variable "environment" {
  type        = string
  description = "Environment name like stg, prd"
}

variable "vpc_name" {
  type        = string
  description = "AWS VPC name"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block of the VPC"
}

variable "private_subnet_num" {
  type        = list
}

variable "public_subnet_num" {
  type        = list
}