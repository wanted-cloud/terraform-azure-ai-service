resource "azurerm_cognitive_deployment" "this" {
  for_each = { for deployment in var.deployments : deployment.name => deployment }

  name                 = each.value.name
  cognitive_account_id = azurerm_cognitive_account.this.id

  dynamic_throttling_enabled = var.dynamic_throttling_enabled
  rai_policy_name            = each.value.rai_policy_name
  version_upgrade_option     = each.value.version_upgrade_option

  model {
    format  = each.value.model.format
    name    = each.value.model.name
    version = each.value.model.version
  }

  sku {
    name = each.value.sku.name

    tier     = try(each.value.sku.tier, null)
    size     = try(each.value.sku.size, null)
    family   = try(each.value.sku.family, null)
    capacity = try(each.value.sku.capacity, null)
  }

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_cognitive_deployment"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_cognitive_deployment"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_cognitive_deployment"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_cognitive_deployment"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}