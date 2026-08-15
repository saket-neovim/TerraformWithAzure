output "tenant_id" {
  value       = data.azurerm_client_config.current.tenant_id
  description = "Tenant ID value"
  # known

}

output "rg_id" {
  value       = azurerm_resource_group.this.id
  description = "resource group id"
  # not known during plan
}

output "storage_endpoint" {
  value       = azurerm_storage_account.this.primary_blob_endpoint
  description = "storage account endpoint"
  # not known during plan

}