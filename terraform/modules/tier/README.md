Tier Terraform Module
=====================

---

A terraform module to create the needed resources for V3 tier,
this includes: security groups, ec2 instances, load balancers

Supported Tiers include:

* Web Tier
* App Tier
* Data Tier

A tier can be either public or private.

Although a three tiered architecture is recommended, it is not required.
For example you may only need the app tier and data tier for a given
project or in some cases only need the app tier (Example: When using RDS as the
data tier)


Module Input Variables
----------------------

- `identifier` - name string to be used on all resources. Unique to the
  project env. Example: lvdv-live
- `aws` - map containing various aws account settings
- `vpc` - map containing various vpc details
- `project` - map containing various project details
- `env` - map containing environment details
- `allowed-security-groups` - string. Comma separated whitelist of security
groups for accesss to tier
- `allowed-cidrs` - string. Comma separated whitelist of CIDRs for access to tier


Usage
-----

Create a main.tf file as follows:

```hcl
module "app" {
  source                  = "../../modules/tier"
  type                    = "app"
  identifier              = "${module.metadata.identifier_prefix}-app"
  app                     = "${var.app}"
  aws                     = "${var.aws}"
  project                 = "${var.project}"
  env                     = "${var.env}"
  vpc                     = "${var.vpc}"
  allowed-security-groups = "${var.allowed-sg-ids["app"]}"
  allowed-cidrs           = "${var.allowed-cidrs["app"]}"
  default_tags            = "${module.metadata.default_tags}"
}
```

Then you can run terraform as follows:

```
terraform init -var-file=<path to terraform.tfvars file
terraform plan -var-file=<path to terraform.tfvars file
terraform apply -var-file=<path to terraform.tfvars file
```
