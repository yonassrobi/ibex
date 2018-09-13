output "key_name" {
  value = "${element(concat(aws_key_pair.generated.*.key_name, list("")), 0)}"
}

output "public_key" {
  value = "${join("", tls_private_key.default.*.public_key_openssh)}"
}
