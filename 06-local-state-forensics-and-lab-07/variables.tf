# variables.tf
variable "prefix" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }
variable "storage_account" { type = string }