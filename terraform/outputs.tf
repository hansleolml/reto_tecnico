output "rg_net_01_name" {
  description = "El nombre del grupo de recursos de la virtual network."
  value       = azurerm_resource_group.rg_net_01.name
}

output "rg_vm_01_name" {
  description = "El nombre del grupo de recursos de la virtual machine."
  value       = azurerm_resource_group.rg_vm_01.name
}

output "location" {
  description = "La ubicación de los recursos creados."
  value       = azurerm_resource_group.rg_net_01.location
}
