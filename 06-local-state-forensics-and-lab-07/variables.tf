# variables.tf
variable "prefix" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }
variable "storage_account" { type = string }

variable "import_storage_account_id" {
  description = "Full resource ID of the existing lab storage account. Set locally and align its name/resource group with this configuration before importing."
  type        = string
}
