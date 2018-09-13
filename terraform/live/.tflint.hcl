config {
  terraform_version = "0.9.11"
  deep_check = true

  ignore_rule = {
    aws_instance_invalid_type  = true
    aws_instance_previous_type = true
  }

  varfile = ["global/terraform.tfvars", "dev/terraform.tfvars"]
}



