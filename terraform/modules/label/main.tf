# ---------------------------------------------------------------------------------------------------------------------
# - Label Module - Name, Description and Tags
# ---------------------------------------------------------------------------------------------------------------------
resource "null_resource" "default" {
  count = "${var.enabled == "true" ? 1 : 0}"

  triggers = {
    id                  = "${lower(join(var.delimiter, compact(concat(list(var.namespace, var.environment, var.name), var.attributes))))}"
    name                = "${lower(join(var.delimiter, compact(concat(list(var.namespace, var.environment, var.name), var.attributes))))}"
    description         = "${lower(join(" ", compact(concat(list(var.namespace, var.environment, var.name), var.attributes))))}"
    namespace           = "${lower(format("%v", var.namespace))}"
    environment         = "${lower(format("%v", var.environment))}"
    attributes          = "${lower(format("%v", join(var.delimiter, compact(var.attributes))))}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
