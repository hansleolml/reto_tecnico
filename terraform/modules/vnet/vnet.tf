resource "azurerm_network_security_group" "net_sec_group" {
  name                = var.net_sec_group_name
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.address_space
  #dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name             = var.subnet_name_sub1
    address_prefixes = var.subnet_address_prefixes_sub1
  }

  subnet {
    name             = var.subnet_name_sub2
    address_prefixes = var.subnet_address_prefixes_sub2
    security_group   = azurerm_network_security_group.net_sec_group.id
  }

  tags = {
    environment =  var.vnet_tag_env
  }
}