# backend-bootstrap/main.tf
# TODO: create resource group, storage account, and private container for state.
# BROKEN: backend config does not exist yet because the backend must be bootstrapped first.


resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.prefix}storage"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_container" "storage_container" {
  name                  = "primary-container"
  container_access_type = "private"
  storage_account_id    = azurerm_storage_account.storage_account.id
}