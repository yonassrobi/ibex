# ---------------------------------------------------------------------------------------------------------------------
# - ENVIRONMENT - VPC / ENV Details
# ---------------------------------------------------------------------------------------------------------------------
vpc                   = {
  id                   = "vpc-01d25165"
  name                 = "live-dev-vpc"

  availability_zones   = "us-east-1a,us-east-1c,us-east-1d"

  dmz.subnet-ids       = "..."
  dmz.subnet-cidrs     = "..."

  web.subnet-ids       = "..."
  web.subnet-cidrs     = "..."

  app.subnet-ids       = "..."
  app.subnet-cidrs     = "..."

  data.subnet-ids      = "..."
  data.subnet-cidrs    = "..."

  cache.subnet-ids     = "..."
  cache.subnet-cidrs   = "..."
}

env                    = {
    code               = "dv"
    name               = "dev"
}

# ---------------------------------------------------------------------------------------------------------------------
# - ELBs -
# ---------------------------------------------------------------------------------------------------------------------
web_elb                 = {
  count                 = 1
  type                  = ""                                                    # internal or "empty" for external
  subnets               = "..."
}

web_elb_sg_ingress      = [
  {
     from_port   = 80
     to_port     = 80
     protocol    = "tcp"
     cidr_blocks = "0.0.0.0/0"
  }
]

web_elb_listener = [
  {
    instance_port     = "80"
    instance_protocol = "HTTP"
    lb_port           = "80"
    lb_protocol       = "HTTP"
  }
]

web_elb_health_check = [
  {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
]



app_elb                 = {
  count                 = 1
  type                  = "internal"                                            # internal or "empty" for external
  subnets               = "..."
}

app_elb_sg_ingress      = [
  {
     from_port   = 8080
     to_port     = 8080
     protocol    = "tcp"
     cidr_blocks = "..."
  }
]

app_elb_listener = [
    {
      instance_port     = "8080"
      instance_protocol = "HTTP"
      lb_port           = "8080"
      lb_protocol       = "HTTP"
    }
]

app_elb_health_check = [
  {
    target              = "HTTP:8080/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
]


data_elb                 = {
  count                 = 0
  type                  = "internal"                                            # internal or "empty" for external
  subnets               = "..."
}

data_elb_sg_ingress      = [
  {
     from_port   = 27017
     to_port     = 27017
     protocol    = "tcp"
     cidr_blocks = "..."
  }
]

data_elb_listener = [
    {
      instance_port     = "27017"
      instance_protocol = "TCP"
      lb_port           = "27017"
      lb_protocol       = "TCP"
    }
]

data_elb_health_check = [
  {
    target              = "TCP:27017/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
]

#TODO: Add cache tier variables

# ---------------------------------------------------------------------------------------------------------------------
# - INSTANCES -
# ---------------------------------------------------------------------------------------------------------------------
web                                     = {
  count                                 = 1
	ami                                   = "..."
	instance_type                         = "web"
  key_name                              = "..."
  iam_instance_profile                  = "..."
  subnet_id                             = "..."
  security_groups                       = ""
	user_data                             = ""
}

web_sg_ingress      = [
  {
     from_port   = 80
     to_port     = 80
     protocol    = "tcp"
     cidr_blocks = "..."
  }
]

app                                     = {
  count                                 = 1
  ami                                   = "..."
  instance_type                         = "app"
  key_name                              = "..."
  iam_instance_profile                  = "..."
  subnet_id                             = "..."
  security_groups                       = ""
  user_data                             = ""
}

app_sg_ingress      = [
  {
     from_port   = 80
     to_port     = 80
     protocol    = "tcp"
     cidr_blocks = "..."
  }
]


data                                    = {
  count                                 = 3
  ami                                   = "..."
  instance_type                         = "data"
  key_name                              = "..."
  iam_instance_profile                  = "..."
  subnet_id                             = "..."
  security_groups                       = ""
  user_data                             = ""
}

data_sg_ingress      = [
  {
     from_port   = 27017
     to_port     = 27017
     protocol    = "tcp"
     cidr_blocks = "..."
  }
]


# ---------------------------------------------------------------------------------------------------------------------
# - SAMPLE INSTANCE MANDATORY FIELDS -
# This is a sample fields required to create stand-alone instances using tier
# module. In most cases, default empty value signifies creation of resource
# using default value set in variable.
# ---------------------------------------------------------------------------------------------------------------------

instance                                = {
  count                                 = 1                           # number of instances to create, default is 1
	ami                                   = "..."                # string based on global AMI type variable e.g. [CENTOS_MAR_18, WEB_MAR_18]
	instance_type                         = "web"                       # string based on global instance type variable e.g. [WEB=>t2.micro, APP, DATA, NAT]
  key_name                              = "..."                 # empty value implies creation of key pair the standard naming convention
  iam_instance_profile                  = "..."                  # empty value implies creation of iam instance profile
  subnet_id                             = "..."           # empty value implies subnet ids defined in global vpc instance will be passed based on instance type
  security_groups                       = "..."   # comma separated list of security group ids, empty value or "new" implies creation of new security group
	user_data                             = ""                          # empty value implies default user data will be passed based on instance type
}


# ---------------------------------------------------------------------------------------------------------------------
# - SAMPLE INSTANCE OPTIONAL FIELDS -
# This is a sample optional fields to enhance the creation of stand-alone instances
# using tier module. Some fields will be required depending on properties of
# other fields.
# ---------------------------------------------------------------------------------------------------------------------

# Security groups                                                     # becomes mandatory if security_groups field is empty or contains the word "new"
instance_sg_ingress      = [
  {
     from_port   = 80
     to_port     = 80
     protocol    = "tcp"
     cidr_blocks = "..."
  },
  {
     from_port   = 443
     to_port     = 443
     protocol    = "tcp"
     cidr_blocks = "..."
  }
]

# IAM policy
policy                   = {                                         # becomes mandatory if iam_instance_profile field is empty

}

# Monitoring
instance_monitoring                    = ""
instance_metric_name                   = ""
instance_applying_period               = ""
instance_statistic_level               = ""
instance_default_alarm_action          = ""
instance_metric_threshold              = ""

# Network --------------------------------------------------------------------------------------------------------------
instance_associate_public_ip_address   = ""
instance_private_ip                    = ""
instance_source_dest_check             = ""
instance_ipv6_address_count            = ""
instance_ipv6_addresses                = ""
instance_root_iops                     = ""
instance_additional_ips_count          = ""

# EBS ---------------------------------------------------------------------------------------------------------------------
instance_ebs_optimized                 = ""
instance_root_volume_type              = ""
instance_root_iops                     = ""
instance_ebs_device_name               = ""
instance_ebs_volume_type               = ""
instance_ebs_volume_size               = ""
instance_ebs_iops                      = ""
instance_ebs_volume_count              = ""

# STATUS -----------------------------------------------------------------------------------------------------------------
instance_disable_api_termination       = ""
instance_delete_on_termination         = ""
instance_instance_enabled              = ""
