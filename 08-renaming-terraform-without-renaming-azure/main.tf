# root main.tf, before refactor
# resource "azurerm_resource_group" "foundation" {
#   name     = "${var.prefix}-foundation-rg"
#   location = var.location
# }

# TODO: Move this into modules/foundation without changing the Azure resource.
# TODO: Add module call and moved block or state mv.

module "foundation" {
  source = "./modules/foundation"
  prefix = var.prefix
  location = var.location
}

moved {
  from = azurerm_resource_group.foundation
  to = azurerm_resource_group.foundation
}