output "instance_profile_id" {
  value = "${element(concat(aws_iam_instance_profile.instance_profile.*.id, list("")), 0)}"
}
