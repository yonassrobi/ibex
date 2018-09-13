variable "description" {
  type = "string"
}

variable "name" {
  type = "string"
}

variable "sg_count" {
  description = " number of ELBs"
  default     = 1
}

variable "vpc_id" {
  type = "string"
}

variable "ingress_cidr_blocks" {
  type = "list"
  default = []
}

variable "ingress_with_cidr_blocks" {
  type = "list"
  default = []
}

variable "tags" {
  type = "map"
  default = {}
}
