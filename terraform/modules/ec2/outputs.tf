output "instances_id" {
  description = "List of IDs of instances"
  value       = ["${aws_instance.this.*.id}"]
}

output "availability_zone" {
  description = "List of availability zones of instances"
  value       = ["${aws_instance.this.*.availability_zone}"]
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = ["${aws_instance.this.*.private_ip}"]
}

output "security_groups" {
  description = "List of associated security groups of instances"
  value       = ["${aws_instance.this.*.security_groups}"]
}

output "vpc_security_group_ids" {
  description = "List of associated security groups of instances, if running in non-default VPC"
  value       = ["${aws_instance.this.*.vpc_security_group_ids}"]
}

output "subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = ["${aws_instance.this.*.subnet_id}"]
}

# output "tags" {
#   description = "List of tags of instances"
#   value       = ["${aws_instance.this.*.tags}"]
# }
