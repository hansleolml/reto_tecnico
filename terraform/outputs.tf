output "resource_group_name" {
  description = "El nombre del grupo de recursos."
  value       = azurerm_resource_group.example.name
}

output "resource_group_location" {
  description = "La ubicación del grupo de recursos."
  value       = azurerm_resource_group.example.location
}
