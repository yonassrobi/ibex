variable "namespace" {
  description = "Namespace, which could be your organization name, e.g. 'cp' or 'cloudposse'"
  default = ""
}

variable "environment" {
  description = "environment, e.g. 'prod', 'staging', 'dev', or 'test'"
  default = ""
}

variable "name" {
  description = "Solution name, e.g. 'app' or 'jenkins'"
  default = ""
}

variable "enabled" {
  description = "Set to false to prevent the module from creating any resources"
  default     = "true"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `environment`, etc."
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `policy` or `role`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit`,`XYZ`)"
}
