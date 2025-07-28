variable "name" {
  description = "Name of the AI Service resource."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which the AI Service will be created."
  type        = string
}

variable "location" {
  description = "Location of the resource group in which the AI Service will be created, if not set it will be the same as the resource group."
  type        = string
  default     = ""
}

variable "sku_name" {
  description = "The SKU name of the AI Service."
  type        = string
  default     = "S0"
}

variable "tags" {
  description = "Tags to be applied to the AI Service resources."
  type        = map(string)
  default     = {}
}

variable "dynamic_throttling_enabled" {
  description = "Enable dynamic throttling for the AI Service."
  type        = bool
  default     = false
}

variable "deployments" {
  description = "List of deployments configuration to create for the AI Service."
  type = list(object({
    name = string
    //cognitive_account_id       = string
    dynamic_throttling_enabled = optional(bool, false)
    rai_policy_name            = optional(string, null)
    version_upgrade_option     = optional(string, "OnceNewDefaultVersionAvailable")
    model = object({
      name    = string
      format  = string
      version = optional(string, null)
    })
    sku = optional(object({
      name     = string
      capacity = optional(number, null)
    }), null)
    scale = optional(object({
      type     = string
      capacity = number
    }), null)
  }))
  default = []
}
// Managed identity configuration
variable "identity_type" {
  description = "Type of identity to use for the Azure service plan."
  type        = string
  default     = "SystemAssigned"
}

variable "user_assigned_identity_ids" {
  description = "List of user assigned identity IDs for the Azure service plan."
  type        = list(string)
  default     = []
}

// Public network access
variable "public_network_access_enabled" {
  description = "Enable or disable public network access to the AI Service."
  type        = bool
  default     = true
}

// Custom subdomain name
variable "custom_subdomain_name" {
  description = "Custom subdomain name for the AI Service endpoint."
  type        = string
  default     = null
}