# resource "azurerm_resource_group" "rg1" {
#   name     = "${var.prefix}-app-rg"
#   location = var.location
# }

moved {
  from = azurerm_resource_group.rg1
  to   = azurerm_resource_group.rg2
}

resource "azurerm_resource_group" "rg2" {
  name     = "${var.prefix}-app-rg"
  location = var.location
}