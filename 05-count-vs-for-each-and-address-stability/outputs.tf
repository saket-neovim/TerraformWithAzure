output "subnet" {
  value = {
    for name, subnet in azurerm_subnet.subnetnames_foreach :
    name => subnet.id
  }
}