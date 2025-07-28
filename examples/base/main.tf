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