# ---------------------------------------------------------------------------------------------------------------------
# - MANDATORY VARIABLES -
# ---------------------------------------------------------------------------------------------------------------------
variable "ami" {
  description = "ID of AMI to use for the instance"
}

variable "instance_type" {
  description = "The type of instance to start"
}

variable "key_name" {
  description = "The key name to use for the instance"
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
} # No longer required by AWS but enforced as best practice

variable "security_groups" {
  description = "A list of security group IDs to associate with"
  type        = "list"
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
}

variable "availability_zones" {
  description = "availability zone for ebs"
}

# ---------------------------------------------------------------------------------------------------------------------
# - OPTIONAL VARIABLES -
# ---------------------------------------------------------------------------------------------------------------------

variable "instance_count" {
  description = "Number of instances to launch"
  default     = 1
}

variable "name" {
  description = "Name to be used elb"
  default     = ""
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  default     = ""
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

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = false
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

variable "vpc_id" {
  description = "VPC id for ELB security group"
  default = ""
}

variable "ingress_with_cidr_blocks" {
  type = "list"
  default = []
}

variable "root_volume_type" {
  description = "Type of root volume. Can be standard, gp2 or io1"
  default     = "gp2"
}

variable "root_volume_size" {
  description = "Size of the root volume in gigabytes"
  default     = "25"
}

variable "root_iops" {
  description = "Amount of provisioned IOPS. This must be set if root_volume_type is set to `io1`"
  default     = "0"
}

variable "ebs_device_name" {
  type        = "list"
  description = "Name of the EBS device to mount"
  default     = ["/dev/xvdb", "/dev/xvdc", "/dev/xvdd", "/dev/xvde", "/dev/xvdf", "/dev/xvdg", "/dev/xvdh", "/dev/xvdi", "/dev/xvdj", "/dev/xvdk", "/dev/xvdl", "/dev/xvdm", "/dev/xvdn", "/dev/xvdo", "/dev/xvdp", "/dev/xvdq", "/dev/xvdr", "/dev/xvds", "/dev/xvdt", "/dev/xvdu", "/dev/xvdv", "/dev/xvdw", "/dev/xvdx", "/dev/xvdy", "/dev/xvdz"]
}

variable "ebs_volume_type" {
  description = "The type of EBS volume. Can be standard, gp2 or io1"
  default     = "gp2"
}

variable "ebs_volume_size" {
  description = "Size of the EBS volume in gigabytes"
  default     = "50"
}

variable "ebs_iops" {
  description = "Amount of provisioned IOPS. This must be set with a volume_type of io1"
  default     = "0"
}

variable "ebs_volume_count" {
  description = "Count of EBS volumes that will be attached to the instance"
  default     = "1"
}

variable "delete_on_termination" {
  description = "Whether the volume should be destroyed on instance termination"
  default     = "true"
}

variable "ebs_encrypted" {
  description = "EBS encryption status"
  default     = true
}
