output "subnet_id" {
  value       = azurerm_subnet.app.id
  description = "the id of azure subnet"
}

output "virtual_network" {
  value       = azurerm_virtual_network.this.id
  description = "the id of azure vnet"
}

output "subscription_id" {
    value = data.azurerm_client_config.current.subscription_id
}