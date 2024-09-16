locals {
  common_tags = {
    "Owner" = "Luis Miranda"
  }
  namespaced_service_name = "${var.service_name}-${var.environment}"
}