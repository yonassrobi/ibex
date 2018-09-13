variable "name" {
  description    = "Name of the IAM resources to be created"
}

variable "policy" {
  description    = "Optional. Custom Policy for IAM Instance Profile"
  default        = ""
}

variable "generate_iam_role" {
  description   = "Optional. Flag to indicate generation of new IAM role or not"
  default       = false
}
