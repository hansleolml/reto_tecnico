output "public_ip" {
  description = "IP Publica de la virtual machine creada"
  value       = azurerm_public_ip.ip_public_01.ip_address
}