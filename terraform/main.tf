resource "azurerm_resource_group" "rg_net_01" {
  name     = var.rg_net_01_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "rg_vm_01" {
  name     = var.rg_vm_01_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_network_security_group" "nsg_01" {
  name                = var.nsg_01_name
  location            = azurerm_resource_group.rg_net_01.location
  resource_group_name = azurerm_resource_group.rg_net_01.name

  security_rule {
    name                       = "rule-inbound-22"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "rule-inbound-8080"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_virtual_network" "vnet_01" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg_net_01.location
  resource_group_name = azurerm_resource_group.rg_net_01.name
}

resource "azurerm_subnet" "subnet_01" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_virtual_network.vnet_01.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_01.name
  address_prefixes     = ["10.0.2.0/24"]
}

module "vmachine" {
  source            = "./modules/virtual_machine" # Ruta al módulo
  location          = azurerm_resource_group.rg_vm_01.location
  rg_name           = azurerm_resource_group.rg_vm_01.name
  vm_name           = "virtual-machine-jenkins"
  vm_admin          = "leo"
  vm_sku            = "22_04-lts"
  vm_size           = "Standard_DS1_v2"
  subnet_name       = azurerm_subnet.subnet_01.name
  subnet_id         = azurerm_subnet.subnet_01.id
  vnet_name         = "vnet-mod"
  nic_name          = "nic-vm-01"
  nsg_01_id         = azurerm_network_security_group.nsg_01.id
  ip_public_01_name = "ip-publica-01"
}
