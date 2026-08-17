output "resource_group_id" {
  value = azurerm_resource_group.this.id
}

output "storage_account_id" {
  value = azurerm_storage_account.main.id
}