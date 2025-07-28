<!-- BEGIN_TF_DOCS -->
# wanted-cloud/terraform-azure-ai-service

Terraform building block providing interface for creation of Azure AI Service.

## Table of contents

- [Requirements](#requirements)
- [Providers](#providers)
- [Variables](#inputs)
- [Outputs](#outputs)
- [Resources](#resources)
- [Usage](#usage)
- [Contributing](#contributing)

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>=4.20.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (>=4.20.0)

## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: Name of the AI Service resource.

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: Name of the resource group in which the AI Service will be created.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_custom_subdomain_name"></a> [custom\_subdomain\_name](#input\_custom\_subdomain\_name)

Description: Custom subdomain name for the AI Service endpoint.

Type: `string`

Default: `null`

### <a name="input_deployments"></a> [deployments](#input\_deployments)

Description: List of deployments configuration to create for the AI Service.

Type:

```hcl
list(object({
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
```

Default: `[]`

### <a name="input_dynamic_throttling_enabled"></a> [dynamic\_throttling\_enabled](#input\_dynamic\_throttling\_enabled)

Description: Enable dynamic throttling for the AI Service.

Type: `bool`

Default: `false`

### <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type)

Description: Type of identity to use for the Azure service plan.

Type: `string`

Default: `"SystemAssigned"`

### <a name="input_location"></a> [location](#input\_location)

Description: Location of the resource group in which the AI Service will be created, if not set it will be the same as the resource group.

Type: `string`

Default: `""`

### <a name="input_metadata"></a> [metadata](#input\_metadata)

Description: Metadata definitions for the module, this is optional construct allowing override of the module defaults defintions of validation expressions, error messages, resource timeouts and default tags.

Type:

```hcl
object({
    resource_timeouts = optional(
      map(
        object({
          create = optional(string, "30m")
          read   = optional(string, "5m")
          update = optional(string, "30m")
          delete = optional(string, "30m")
        })
      ), {}
    )
    tags                     = optional(map(string), {})
    validator_error_messages = optional(map(string), {})
    validator_expressions    = optional(map(string), {})
  })
```

Default: `{}`

### <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled)

Description: Enable or disable public network access to the AI Service.

Type: `bool`

Default: `true`

### <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name)

Description: The SKU name of the AI Service.

Type: `string`

Default: `"S0"`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: Tags to be applied to the AI Service resources.

Type: `map(string)`

Default: `{}`

### <a name="input_user_assigned_identity_ids"></a> [user\_assigned\_identity\_ids](#input\_user\_assigned\_identity\_ids)

Description: List of user assigned identity IDs for the Azure service plan.

Type: `list(string)`

Default: `[]`

## Outputs

The following outputs are exported:

### <a name="output_ai_service"></a> [ai\_service](#output\_ai\_service)

Description: The Azure AI Service resource.

## Resources

The following resources are used by this module:

- [azurerm_ai_services.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ai_services) (resource)
- [azurerm_cognitive_deployment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_deployment) (resource)
- [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) (data source)

## Usage

> For more detailed examples navigate to `examples` folder of this repository.

Module was also published via Terraform Registry and can be used as a module from the registry.

```hcl
module "example" {
  source  = "wanted-cloud/..."
  version = "x.y.z"
}
```

### Basic usage example

The minimal usage for the module is as follows:

```hcl
module "template" {
    source = "../.."

    name                = "example-ai-service"
    resource_group_name = "example-rg"

    deployments = [{
      name = "example-deployment-embedding"
      model = {
        name    = "text-embedding-3-large"
        format  = "OpenAI"
        version = "1"
    }
      sku = {
        name = "Standard"
      }
    }]
}
```
## Contributing

_Contributions are welcomed and must follow [Code of Conduct](https://github.com/wanted-cloud/.github?tab=coc-ov-file) and common [Contributions guidelines](https://github.com/wanted-cloud/.github/blob/main/docs/CONTRIBUTING.md)._

> If you'd like to report security issue please follow [security guidelines](https://github.com/wanted-cloud/.github?tab=security-ov-file).
---
<sup><sub>_2025 &copy; All rights reserved - WANTED.solutions s.r.o._</sub></sup>
<!-- END_TF_DOCS -->