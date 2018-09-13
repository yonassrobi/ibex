# ---------------------------------------------------------------------------------------------------------------------
# - SECURITY GROUP MODULE - creates security group with provided ingress and default egress rules
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" "this" {
  count                    = "${var.sg_count}"
  name                     = "${var.name}"
  description              = "${var.description}"
  vpc_id                   = "${var.vpc_id}"
  tags                     = "${var.tags}"
}

# ---------------------------------------------------------------------------------------------------------------------
# - Ingress Rule -
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_security_group_rule" "ingress_with_cidr_blocks" {
  type                     = "ingress"
  count                    = "${var.sg_count == 0 ? 0 : length(var.ingress_with_cidr_blocks)}"
  security_group_id        = "${aws_security_group.this.id}"
  cidr_blocks              = ["${split(",", lookup(var.ingress_with_cidr_blocks[count.index], "cidr_blocks", join(",", var.ingress_cidr_blocks)))}"]
  description              = "${lookup(var.ingress_with_cidr_blocks[count.index], "description", "Ingress Rule")}"

  from_port                = "${lookup(var.ingress_with_cidr_blocks[count.index], "from_port")}"
  to_port                  = "${lookup(var.ingress_with_cidr_blocks[count.index], "to_port")}"
  protocol                 = "${lookup(var.ingress_with_cidr_blocks[count.index], "protocol")}"

  lifecycle {
    ignore_changes = ["description"]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# - Egress Rule -
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_security_group_rule" "allow_outbound" {
  count                   = "${var.sg_count}" 
  type                    = "egress"
  from_port               = 0
  to_port                 = 0
  protocol                = "-1"
  cidr_blocks             = ["0.0.0.0/0"]
  security_group_id       = "${aws_security_group.this.id}"
}
