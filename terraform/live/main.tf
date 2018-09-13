# ---------------------------------------------------------------------------------------------------------------------
# - MAIN MODULE -
# ---------------------------------------------------------------------------------------------------------------------
#  Initializes TIER Module to create consistent infrastructure across environments.
#  Launches ELBs (Web, App), INSTANCES (Web, App) and MongoDB cluster databases
#  with appropriate security groups, key pairs, iam roles and standardized tags.
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# - Provider - AWS region
# ---------------------------------------------------------------------------------------------------------------------
provider "aws" {
  region                                 = "${var.aws["region"]}"
}

# ---------------------------------------------------------------------------------------------------------------------
# - LABEL - Name, Description and Tags
# ---------------------------------------------------------------------------------------------------------------------
module "default_label" {
  source                                 = "../modules/label"
  tags                                   = "${var.default_tags}"
  enabled                                = false
}

# ---------------------------------------------------------------------------------------------------------------------
# - Web Tier -
# ---------------------------------------------------------------------------------------------------------------------
module "web" {
  source                  = "../modules/tier"

  type                    = "web"
  aws                     = "${var.aws}"
  vpc                     = "${var.vpc}"
  env                     = "${var.env}"

  elb                     = "${var.web_elb}"
  instance                = "${var.web}"

  elb_listener            = "${var.web_elb_listener}"        #make me optional
  elb_health_check        = "${var.web_elb_health_check}"    #make me optional
  elb_sg_ingress          = "${var.web_elb_sg_ingress}"      #make me optional
  instance_sg_ingress     = "${var.web_sg_ingress}"          #make me optional

  amis                    = "${var.amis}"                    #make me optional
  instance_types          = "${var.instance_types}"
  available_user_data     = "${var.available_user_data}"    #make me optional

  default_tags            = "${module.default_label.tags}"
}

# ---------------------------------------------------------------------------------------------------------------------
# - App Tier -
# ---------------------------------------------------------------------------------------------------------------------
module "app" {
  source                  = "../modules/tier"

  type                    = "app"
  aws                     = "${var.aws}"
  vpc                     = "${var.vpc}"
  env                     = "${var.env}"

  elb                     = "${var.app_elb}"
  instance                = "${var.app}"

  elb_listener            = "${var.app_elb_listener}"        #make me optional
  elb_health_check        = "${var.app_elb_health_check}"    #make me optional
  elb_sg_ingress          = "${var.app_elb_sg_ingress}"      #make me optional
  instance_sg_ingress     = "${var.app_sg_ingress}"          #make me optional

  amis                    = "${var.amis}"                    #make me optional
  instance_types          = "${var.instance_types}"
  available_user_data     = "${var.available_user_data}"    #make me optional

  default_tags            = "${module.default_label.tags}"
}

# ---------------------------------------------------------------------------------------------------------------------
# - Data Tier -
# ---------------------------------------------------------------------------------------------------------------------
module "data" {
  source                  = "../modules/tier"

  type                    = "data"
  aws                     = "${var.aws}"
  vpc                     = "${var.vpc}"
  env                     = "${var.env}"

  elb                     = "${var.data_elb}"
  instance                = "${var.data}"

  elb_listener            = "${var.data_elb_listener}"        #make me optional
  elb_health_check        = "${var.data_elb_health_check}"    #make me optional
  elb_sg_ingress          = "${var.data_elb_sg_ingress}"      #make me optional
  instance_sg_ingress     = "${var.data_sg_ingress}"          #make me optional

  amis                    = "${var.amis}"                    #make me optional
  instance_types          = "${var.instance_types}"
  available_user_data     = "${var.available_user_data}"    #make me optional

  default_tags            = "${module.default_label.tags}"
}


# ---------------------------------------------------------------------------------------------------------------------
# - SAMPLE INSTANCE EXAMPLE -
# ---------------------------------------------------------------------------------------------------------------------

# locals = {
#   ami                                   = "${var.instance["ami"] != "" ? var.amis[var.instance["ami"]] : "-1"}"
#   instance_count                        = "${var.instance["count"] != "" ? var.instance["count"]: 0}"
#   instance_type                         = "${var.instance["instance_type"] != "" ? var.instance_types[var.instance["instance_type"]] : "t2.micro"}"
#   key_name                              = "${var.instance["key_name"] != "" ? var.instance["key_name"] : ""}" #TODO: create if empty
#   iam_instance_profile                  = "${var.instance["iam_instance_profile"] != "" ? var.instance["iam_instance_profile"] : "-1"}"
#   subnet_id                             = "${var.instance["subnet_id"] != "" ? var.instance["subnet_id"] : ""}"
#   security_groups                       = ["${split(",", var.instance["security_groups"] != "" ? join(",",split(",",var.instance["security_groups"])) : join(",",split(",",var.instance["security_groups"])) )}"]
#   user_data                             = "${var.instance["user_data"] != "" ? var.instance["user_data"] : var.available_user_data[var.instance["instance_type"]]}"
# }
#

# module "instance" {
#   source                                =  "../modules/ec2"
#
#   ami                                   = "${local.ami}"
#   instance_count                        = "${local.instancecount}"
#   instance_type                         = "${local.instance_type}"
#   key_name                              = "${local.key_name}"
#   iam_instance_profile                  = "${local.iam_instance_profile}"
#   subnet_id                             = "${local.subnet_id}"
#   security_groups                       =["${local.security_groups}"]
#   user_data                             = "${local.user_data}"
#
#   tags                                  = "${module.label.default_tags}"
# }
