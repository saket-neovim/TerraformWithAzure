data "azurerm_client_config" "current" {}

locals {
  base_name = lower("${var.prefix}-${local.tags["environment"]}")
  tags = {
    "environment" = "Staging"
    "ManagedBy"   = "Terraform"
  }
}

resource "azurerm_resource_group" "this" {
  name     = "${local.base_name}-rg"
  location = var.location
}

resource "azurerm_storage_account" "this" {
  # BROKEN IDEA: do not build stable names from IDs created only after apply.
  name                     = lower(replace("${var.prefix}${local.tags["environment"]}", "-", ""))
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags
}

# TODO: Refactor the name so it is stable and valid at plan time.
