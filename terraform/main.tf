resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}


module "networking" {
  source = "./modules/vnet" # Ruta al módulo
  #resource_group_name   = azurerm_resource_group.rg_vnet.name
  location                     = var.location
  rg_name                      = azurerm_resource_group.rg_vnet.name
  vnet_name                    = "vnet-mod"
  subnet_name_sub1             = "subnet_1"
  subnet_name_sub2             = "subnet_2"
  net_sec_group_name           = "sec_group_nombre"
  vnet_tag_env                 = "dev"
  address_space                = ["10.1.0.0/16"]
  subnet_address_prefixes_sub1 = ["10.1.1.0/24"]
  subnet_address_prefixes_sub2 = ["10.1.2.0/24"]
}


resource "azurerm_resource_group" "rg_vnet" {
  name     = var.rg_vnet_name
  location = var.location
}