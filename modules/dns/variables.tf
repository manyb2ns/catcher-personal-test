variable "project" {
  type        = string
  description = "Project Name"
}

variable "environment" {
  type        = string
  description = "Environment name like stg, prd"
}

variable "domain" {
  type        = string
  description = "Domain URL"
}

variable "record" {
  type        = map(string)
  description = "DNS record"

  default = {
    name = ""
    type = ""
    records = ""
  }
}