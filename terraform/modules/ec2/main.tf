# ---------------------------------------------------------------------------------------------------------------------
# - EC2 INSTANCE MODULE -
# Creates EC2 instance(s) with a given ami, instance type, iam profile, tags,
# root volume and ebs storage.
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_instance" "this" {
  count                                = "${var.instance_count}"

  ami                                  = "${var.ami}"
  instance_type                        = "${var.instance_type}"
  subnet_id                            = "${element(split(",", var.subnet_id), count.index)}"               # HA configuration to launch instances in multiple subnets / AZ
  key_name                             = "${var.key_name}"
  iam_instance_profile                 = "${var.iam_instance_profile}"
  security_groups                      =  ["${var.security_groups}"]
  user_data                            = "${var.user_data}"

  associate_public_ip_address          = "${var.associate_public_ip_address}"
  private_ip                           = "${var.private_ip}"
  monitoring                           = "${var.monitoring}"
  source_dest_check                    = "${var.source_dest_check}"
  disable_api_termination              = "${var.disable_api_termination}"
  instance_initiated_shutdown_behavior = "${var.instance_initiated_shutdown_behavior}"
  placement_group                      = "${var.placement_group}"
  tenancy                              = "${var.tenancy}"

  root_block_device {
    volume_type                        = "${var.root_volume_type}"
    volume_size                        = "${var.root_volume_size}"
    iops                               = "${var.root_iops}"
    delete_on_termination              = "${var.delete_on_termination}"
  }

  tags                                  = "${merge(var.tags, map("Name", format("%s-00%d", var.name, count.index+1)))}"
  # TODO: add conditional flag to append 00(count) only if count is greater than 1  = "${var.instance_count > 1 ? merge(var.tags, map("Name", format("%s-00%s", var.name, count.index))) : var.tags}"

  lifecycle {
    ignore_changes = ["private_ip", "vpc_security_group_ids", "root_block_device", "security_groups"]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# - EBS VOLUME -
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_ebs_volume" "this" {
  count                               = "${var.ebs_volume_count}"
  availability_zone                   = "${element(split(",", var.availability_zones), count.index)}"
  size                                = "${var.ebs_volume_size}"
  type                                = "${var.ebs_volume_type}"
  encrypted                           = "${var.ebs_encrypted}"
  #iops                               = "${local.ebs_iops}"
  tags                                = "${var.tags}"
}

# ---------------------------------------------------------------------------------------------------------------------
# - EBS VOLUME ATTACHMENT -
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_volume_attachment" "default" {
  count                               = "${var.ebs_volume_count}"
  device_name                         = "${element(var.ebs_device_name, count.index)}"
  volume_id                           = "${element(aws_ebs_volume.this.*.id, count.index)}"
  instance_id                         = "${element(concat(aws_instance.this.*.id, list("")), count.index)}"
}

# # ---------------------------------------------------------------------------------------------------------------------
# # - AMI - DEFAULT AMI -
# # ---------------------------------------------------------------------------------------------------------------------
# data "aws_ami" "default_ami" {
#   most_recent = true
#
#   filter {
#     name   = "owner-alias"
#     values = ["amazon"]
#   }
#
#   filter {
#     name   = "name"
#     values = ["amzn-ami-${var.ami_version}-amazon-ecs-optimized"]
#   }
# }
#
# # ---------------------------------------------------------------------------------------------------------------------
# # - USER DATA - DEFAULT AMI -
# # ---------------------------------------------------------------------------------------------------------------------
# data "template_file" "user_data" {
#   template = "${file("${path.module}/templates/user_data.tpl")}"
#
#   vars {
#     additional_user_data_script = "${var.additional_user_data_script}"
#     cluster_name                = "${aws_ecs_cluster.cluster.name}"
#     docker_storage_size         = "${var.docker_storage_size}"
#     dockerhub_token             = "${var.dockerhub_token}"
#     dockerhub_email             = "${var.dockerhub_email}"
#   }
# }
