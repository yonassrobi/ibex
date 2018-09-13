output "id" {
  value       = "${join("", null_resource.default.*.triggers.id)}"
  description = "Disambiguated ID"
}

output "name" {
  value       = "${join("", null_resource.default.*.triggers.name)}"
  description = "Normalized name"
}

output "description" {
  value       = "${join("", null_resource.default.*.triggers.description)}"
  description = "Normalized description"
}

output "namespace" {
  value       = "${join("", null_resource.default.*.triggers.namespace)}"
  description = "Normalized namespace"
}

output "environment" {
  value       = "${join("", null_resource.default.*.triggers.environment)}"
  description = "Normalized environment"
}

output "attributes" {
  value       = "${join("", null_resource.default.*.triggers.attributes)}"
  description = "Normalized attributes"
}

output "tags" {
  value = "${
      merge(
        var.tags,
        map(
          "Name", "${join("", null_resource.default.*.triggers.id)}",
          "Description", "${join("", null_resource.default.*.triggers.description)}",
          "Namespace", "${join("", null_resource.default.*.triggers.namespace)}",
          "Environment", "${join("", null_resource.default.*.triggers.environment)}"
        )
      )
    }"

  description = "Normalized Tag map"
}
