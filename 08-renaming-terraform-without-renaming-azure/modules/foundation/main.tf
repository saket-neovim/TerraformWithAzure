resource "azurerm_resource_group" "foundation" {
  name     = "${var.prefix}-foundation-rg"
  location = var.location
}
