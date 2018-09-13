variable "name" {
  description = "The name of the ELB"
}

variable "elb_count" {
  description = " number of ELBs"
  default     = 1
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the ELB"
  type        = "list"
  default     = []
}

variable "vpc_id" {
  description = "VPC id for ELB security group"
  default = ""
}

variable "subnets" {
  description = "A list of subnet IDs to attach to the ELB"
  type        = "list"
}

variable "internal" {
  description = "If true, ELB will be an internal ELB"
}

variable "cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing"
  default     = true
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle"
  default     = 60
}

variable "connection_draining" {
  description = "Boolean to enable connection draining"
  default     = false
}

variable "connection_draining_timeout" {
  description = "The time in seconds to allow for connections to drain"
  default     = 300
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

# Listener
variable "listener" {
  description = "A list of listener blocks"
  type        = "list"
}

# Access logs
variable "access_logs" {
  description = "An access logs block"
  type        = "list"
  default     = []
}

# Health check
variable "health_check" {
  description = "A health check block"
  type        = "list"
}

variable "ingress_with_cidr_blocks" {
  type = "list"
  default = []
}
