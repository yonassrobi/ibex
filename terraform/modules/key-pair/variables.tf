variable "name" {
  description    = "map"
  default        = ""
}

variable "tags" {
  type    = "map"
  default = {}
}

variable "ssh_public_key_path" {
  description = "Path to Read/Write SSH Public Key File (directory)"
  default = "~/.ssh/terraform/"
}

variable "generate_ssh_key" {
  description = "Generate key pair if true"
  default = false
}

variable "ssh_key_algorithm" {
  default = "RSA"
}

variable "private_key_extension" {
  type    = "string"
  default = ""
}

variable "public_key_extension" {
  type    = "string"
  default = ".pub"
}

variable "chmod_command" {
  default = "chmod 600 %v"
}
