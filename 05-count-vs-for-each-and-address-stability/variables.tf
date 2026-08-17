variable "subnet_names_foreach" {
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "subnet_names" {
  type    = list(string)
  default = ["app", "data"]
}

variable "prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}