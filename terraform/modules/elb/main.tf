# ---------------------------------------------------------------------------------------------------------------------
# - ELB MODULE - create internal or external AWS Elastic Load Balancer
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_elb" "this" {
  count                                = "${var.elb_count}"
  name                                 = "${var.name}"

  # access_logs {                                                               #TODO: provide option to enable access log
  #   bucket                           = "access.logs"
  #   bucket_prefix                    = "${var.name}"
  #   interval                         = 60
  # }

  subnets                              = ["${var.subnets}"]
  internal                             = "${var.internal}"
  security_groups                      = ["${var.security_groups}"]

  listener                             = ["${var.listener}"]
  access_logs                          = ["${var.access_logs}"]
  health_check                         = ["${var.health_check}"]

  cross_zone_load_balancing            = "${var.cross_zone_load_balancing}"
  idle_timeout                         = "${var.idle_timeout}"
  connection_draining                  = "${var.connection_draining}"
  connection_draining_timeout          = "${var.connection_draining_timeout}"

  tags = "${var.tags}"
}
