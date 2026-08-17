resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_subnet" "subnetnames_foreach" {
  for_each             = var.subnet_names_foreach
  name                 = "snet-${each.key}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_virtual_network" "this" {
  name                = "${var.prefix}-vnet"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.30.0.0/16"]
  tags                = var.tags
}

# resource "azurerm_subnet" "this" {
#   count                = length(var.subnet_names)
#   name                 = "snet-${var.subnet_names[count.index]}"
#   resource_group_name  = azurerm_resource_group.this.name
#   virtual_network_name = azurerm_virtual_network.this.name
#   address_prefixes     = [cidrsubnet("10.30.0.0/16", 8, count.index)]
# }

moved {
  from = azurerm_subnet.this[0]
  to   = azurerm_subnet.subnetnames_foreach["app"]
}

moved {
  from = azurerm_subnet.this[1]
  to   = azurerm_subnet.subnetnames_foreach["data"]
}

# TODO: Apply once, then insert "api" between app and data.
# TODO: Refactor to for_each using stable keys and preserve state.