locals {
  base_tags = {
    DeploymentIdentifier = var.deployment_identifier
  }

  tags = merge(var.tags, local.base_tags)
}