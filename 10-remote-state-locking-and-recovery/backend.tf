# app/backend.tf.example
terraform {
  backend "azurerm" {
    resource_group_name  = "tfazlab-rg"
    storage_account_name = "tfazlabstorage"
    container_name       = "primary-container"
    key                  = "lab10.tfstate"
  }
}