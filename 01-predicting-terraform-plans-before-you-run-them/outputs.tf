output "resource_group_name" {
  value       = azurerm_resource_group.this.name
  description = "The azure resource group name"
}

output "storage_account" {
  value       = azurerm_storage_account.main.id
  description = "The storage account id"
}