resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "random_string" "suffix" {
  length  = 3
  special = false
  upper   = false
  numeric = false
}

resource "azurerm_storage_account" "this" {
  name                     = "${var.prefix}${random_string.suffix.result}" # BROKEN/TODO: must be globally unique and 3-24 lowercase chars.
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags

  # lifecycle {
  #   prevent_destroy = true
  # }
}

data "azurerm_client_config" "current" {
}

