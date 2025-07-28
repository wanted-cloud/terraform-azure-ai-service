/*
 * # wanted-cloud/terraform-azure-ai-service
 * 
 * Terraform building block providing interface for creation of Azure AI Service.
 */

resource "azurerm_ai_services" "this" {
  name                = var.name
  location            = var.location != "" ? var.location : data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  sku_name            = var.sku_name

  public_network_access = var.public_network_access_enabled ? "Enabled" : "Disabled"
  custom_subdomain_name = var.custom_subdomain_name != "" ? var.custom_subdomain_name : null

  identity {
    type         = var.identity_type
    identity_ids = var.user_assigned_identity_ids
  }


  tags = merge(local.metadata.tags, var.tags)

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_ai_services"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_ai_services"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_ai_services"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_ai_services"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }

}