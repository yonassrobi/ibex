# aws account details
variable "aws" {
  description = "AWS Details, including 'account', 'alias' and 'region'"
  default = {
    region = "us-east-1"
    namespace = "live"
    alias = "lv"
    id = ""
    account = ""
  }
}

variable "vpc" {
  type        = "map"
  description = "VPC Details, including 'id', 'name', 'db.subnet-ids', 'db.subnet-cidrs', 'app.subnet-ids', 'app.subnet-cidrs'"
}

variable "env" {
  type        = "map"
  description = "Environment Details, including 'code', 'name'"
}

variable "default_tags" {
  type        = "map"
  default     = {}
}

############
# Inputs
#############

variable "instance" {
  type        = "map"
  description = "details like port, public, https. etc"
}

variable "allowed-security-groups" {
  description = "SGs Allowed to connect with DB"
  default = {}
}

variable "policy" {
  description = "Instance IAM role policy"
  default     = ""
}

variable "identifier" {
  description = "Resource name prefix"
  default = ""
}

# variable "project" {
#   type        = "map"
#   description = "Project Details, including 'code', 'name'"
# }

variable "type" {
  description = "Tier type, can be web, app or db"
}

variable "instance_sg_ingress" {
  type        = "list"
  default     = []
}

variable "elb_sg_ingress" {
  type        = "list"
  default     = []
}

variable "elb_listener" {
  type        = "list"
}

variable "elb_health_check" {
  type        = "list"
}

#...............
variable "elb" {
  type        = "map"
}

variable "instance_types" {
  description  = "Available instance type "
  type         = "map"
}

variable "amis" {
  description = "Available instance Amazon Machine Images (AMIs)"
  type = "map"
}

variable "available_user_data" {
  description = "Available user data templates based on instance type"
  type = "map"
  default = {
    "default"    = "default_user_data.txt"
  }
}

###########
#Instances
###########

variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = ""
}

variable "instance_count" {
  description = "Number of instances to launch"
  default     = 1
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  default = ""
}

variable "list_of_amis" {
  type = "map"

  default = {
    cent_os_march = "ami-2051294a"
    rhel_os_march = "ami-9999999a"
  }
}

variable "placement_group" {
  description = "The Placement Group to start the instance in"
  default     = ""
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
  default     = "default"
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = false
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance" # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior
  default     = ""
}

variable "instance_type" {
  description = "The type of instance to start"
  default     = ""
}

variable "key_name" {
  description = "The key name to use for the instance"
  default     = ""
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = false
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = "list"
  default     = []
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  default = ""
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  default     = false
}

variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  default     = ""
}

variable "source_dest_check" {
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs."
  default     = true
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  default     = ""
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
  default     = ""
}

variable "ipv6_address_count" {
  description = "A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet."
  default     = 0
}

variable "ipv6_addresses" {
  description = "Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface"
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  default     = {}
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  default     = []
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  default     = []
}

variable "ephemeral_block_device" {
  description = "Customize Ephemeral (also known as Instance Store) volumes on the instance"
  default     = []
}

variable "network_interface" {
  description = "Customize network interfaces to be attached at instance boot time"
  default     = []
}
