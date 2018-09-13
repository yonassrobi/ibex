# ---------------------------------------------------------------------------------------------------------------------
# - TIER MODULE -
# This module deploys a web, app or data tier resources with an optional Elastic Load
# Balancer (ELB) in front of it. The resource primarily consist of ELB, EC2 Instance(s)
# and security groups.
# ---------------------------------------------------------------------------------------------------------------------
locals = {
  ami                                   = "${var.instance["ami"] != "" ? var.amis[format("%s-%s",var.aws["region"],var.instance["ami"])] : "-1"}"
  instance_count                        = "${var.instance["count"] != "" ? var.instance["count"]: 1}"
  instance_type                         = "${var.instance["instance_type"] != "" ? var.instance_types[var.instance["instance_type"]] : "t2.micro"}"
  key_name                              = "${var.instance["key_name"] != "" ? var.instance["key_name"] : "${module.label_ec2.name}"}"
  iam_instance_profile                  = "${var.instance["iam_instance_profile"] != "" ? var.instance["iam_instance_profile"] : ""}"
  security_groups                       = ["${split(",", var.instance["security_groups"] != "" ? join(",",split(",",var.instance["security_groups"])) : join(",", module.instance_security_group.security_group_id ))}"]
  user_data                             = "${var.instance["user_data"] != "" ? var.instance["user_data"] : var.available_user_data[var.instance["instance_type"]]}"
  vpc_id                                = "${var.vpc["id"]}"
  is_elb_internal                       = "${var.elb["type"] == "internal" ? "true" :  "false" }"
}

# ---------------------------------------------------------------------------------------------------------------------
# - ELB -
# ---------------------------------------------------------------------------------------------------------------------
# uses ELB module to create internal or external Elastic Load
# Balancers and appropriate security groups, health check and listeners
# ---------------------------------------------------------------------------------------------------------------------
module "elastic_load_balancer" {
  source                                = "../elb"
  elb_count                             = "${var.elb["count"]}"
  name                                  = "${format("%s-%s-%s-%selb", var.aws["namespace"], var.env["name"] , var.type, var.elb["type"])}"                               #"${module.label_elb.name}"
  subnets                               = ["${split(",", var.elb["subnets"])}"]
  internal                              = "${local.is_elb_internal}"
  listener                              = ["${var.elb_listener}"]                                  # TODO: make it optional
  health_check                          = ["${var.elb_health_check}"]
  security_groups                       = ["${module.elb_security_group.security_group_id}"]       # TODO: allow other sg ids to be passed
  vpc_id                                = "${var.vpc["id"]}"
  tags                                  = "${module.label_elb.tags}"
}


# ---------------------------------------------------------------------------------------------------------------------
# EC2 Instance(s)
# ---------------------------------------------------------------------------------------------------------------------
module "instance" {
  source = "../ec2"

  name                                  = "${format("%s-%s-%s", var.aws["namespace"], var.env["name"] , var.type)}"
  ami                                   = "${local.ami}"
  instance_count                        = "${local.instance_count}"
  instance_type                         = "${local.instance_type}"
  key_name                              = "${local.key_name}"
  iam_instance_profile                  = "${local.iam_instance_profile}"
  subnet_id                             = "${var.instance["subnet_id"]}"
  security_groups                       =["${local.security_groups}"]
  user_data                             = "${local.user_data}"

  monitoring                            = "${var.monitoring}"
  private_ip                            = "${var.private_ip}"
  ebs_optimized                         = "${var.ebs_optimized}"
  volume_tags                           = "${var.volume_tags}"
  root_block_device                     = "${var.root_block_device}"
  ebs_block_device                      = "${var.ebs_block_device}"
  ephemeral_block_device                = "${var.ephemeral_block_device}"

  vpc_id                                = "${local.vpc_id}"
  availability_zones                    = "${var.aws["availability_zones"]}"

  source_dest_check                     = "${var.source_dest_check}"
  disable_api_termination               = "${var.disable_api_termination}"
  instance_initiated_shutdown_behavior  = "${var.instance_initiated_shutdown_behavior}"
  placement_group                       = "${var.placement_group}"
  tenancy                               = "${var.tenancy}"
  tags                                  = "${module.label_ec2.tags}"
}

# ---------------------------------------------------------------------------------------------------------------------
# - ELB Security Group -
# ---------------------------------------------------------------------------------------------------------------------
module "elb_security_group" {
  source                                = "../security-group"
  sg_count                              = "${var.elb["count"] == 0 ? 0 : 1}"
  name                                  = "${module.label_elb_sg.name}"
  description                           = "${module.label_elb_sg.description}"
  vpc_id                                = "${local.vpc_id}"
  ingress_with_cidr_blocks              = "${var.elb_sg_ingress}"
  tags                                  = "${module.label_elb_sg.tags}"
}

# ---------------------------------------------------------------------------------------------------------------------
# - EC2 Instance Security Group -
# ---------------------------------------------------------------------------------------------------------------------
module "instance_security_group" {
  source                                = "../security-group"
  sg_count                              = "${local.instance_count == 0 ? 0 : 1}"
  name                                  = "${module.label_ec2_sg.name}"
  description                           = "${module.label_ec2_sg.description}"
  vpc_id                                = "${local.vpc_id}"
  ingress_with_cidr_blocks              = "${var.instance_sg_ingress}"
  tags                                  = "${module.label_ec2_sg.tags}"
}

# ---------------------------------------------------------------------------------------------------------------------
# - ELB Attachment  -
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_elb_attachment" "this" {
  count    = "${local.instance_count != 0 && var.elb["count"] != 0 ? local.instance_count : 0}"
  elb      = "${element(module.elastic_load_balancer.elb_id,0)}"
  instance = "${module.instance.instances_id[count.index]}"
}


# ---------------------------------------------------------------------------------------------------------------------
# EC2 Instance Key pair
# ---------------------------------------------------------------------------------------------------------------------
module "key_pair" {
  source                                = "../key-pair"
  name                                  = "${module.label_ec2.name}"
  generate_ssh_key                      = "${local.key_name == "" ? true : false}"
}

# ---------------------------------------------------------------------------------------------------------------------
# Instance IAM Profile
# ---------------------------------------------------------------------------------------------------------------------
module "iam" {
  source                                = "../iam"
  name                                  = "${module.label_ec2.name}"
  policy                                = "${var.policy}"
  generate_iam_role                     = "${local.iam_instance_profile == "" ? "true" : "false"}"
}

# ---------------------------------------------------------------------------------------------------------------------
# - LABELS -
# ---------------------------------------------------------------------------------------------------------------------
module "label_elb" {
  source       = "../label"
  enabled      = "${var.elb["count"] == 0 ? false : true}"
  namespace    = "${var.aws["namespace"]}"
  environment  = "${var.env["name"]}"
  attributes   = ["${var.type}", "${var.elb["type"]}", "elb"]
  tags         = "${var.default_tags}"
}

module "label_elb_sg" {
  source       = "../label"
  enabled      = "${var.elb["count"] == 0 ? false : true}"
  namespace    = "${var.aws["namespace"]}"
  environment  = "${var.env["name"]}"
  attributes   = ["${var.type}", "elb", "sg"]
  tags         = "${var.default_tags}"
}

module "label_ec2" {
  source       = "../label"
  enabled      = "${local.instance_count == 0 ? false : true}"
  namespace    = "${var.aws["namespace"]}"
  environment  = "${var.env["name"]}"
  attributes   = ["${var.type}"]
  tags         = "${var.default_tags}"
}

module "label_ec2_sg" {
  source       = "../label"
  enabled      = "${local.instance_count == 0 ? false : true}"
  namespace    = "${var.aws["namespace"]}"
  environment  = "${var.env["name"]}"
  attributes   = ["${var.type}", "sg"]
  tags         = "${var.default_tags}"
}
