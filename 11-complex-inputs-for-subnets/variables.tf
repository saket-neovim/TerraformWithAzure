variable "subnets" {
  type = map(object({
    cidr              = string
    service_endpoints = optional(list(string), [])
    create_nsg        = optional(bool, false)
    delegation        = optional(object({ name = string, service = string }))
  }))
  default = {
    app = { cidr = "10.0.1.0/24", create_nsg = true }
    pe  = { cidr = "10.0.2.0/24" }
  }
}

locals {
  normalized_subnets = var.subnets # TODO: normalize optional fields once here.
}

# variables.tf
variable "prefix" {
  type    = string
  default = "tfaz"
}
variable "location" {
  type    = string
  default = "East US"
}
variable "tags" {
  type = map(string)
  default = {

    "environment" = "Staging"
    "ManagedBy"   = "Terraform"

  }
}
variable "storage_account" { type = string }

# TODO: create subnets with for_each and output IDs by key.