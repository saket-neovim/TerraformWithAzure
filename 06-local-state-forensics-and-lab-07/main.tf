# main.tf
resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_storage_account" "main" {
  name                     = var.storage_account
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

# removed {
#   from = azurerm_storage_account.main

#   lifecycle {
#     destroy = false
#   }
# }

import {
  to = azurerm_storage_account.main
  id = "/subscriptions/f494677c-c695-4fff-9d7f-160c71b88534/resourceGroups/tfazlab-rg/providers/Microsoft.Storage/storageAccounts/mymainstorageaccount1269"
}