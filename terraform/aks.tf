resource "azurerm_resource_group" "rg_aks_01" {
  name     = var.rg_aks_01_name
  location = var.location_aks
}

resource "azurerm_virtual_network" "vnet_02" {
  name                = var.vnet_02_name
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg_aks_01.location
  resource_group_name = azurerm_resource_group.rg_net_01.name
}

resource "azurerm_subnet" "subnet_02" {
  name                 = var.subnet_02_name
  resource_group_name  = azurerm_virtual_network.vnet_02.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_02.name
  address_prefixes     = ["10.1.1.0/24"]
}

module "aks" {
  source                           = "./modules/kubernetes" # Ruta al módulo
  load_balancer_name               = "load-balancer-01"
  aks_01_name                      = "aks-cluster-prueba"
  aks_01_version                   = "1.29.9"
  location_aks                     = "West US 2 "
  aks_01_dns_prefix                = "aks-cluster-prueba-dns"
  rg_aks_01_name                   = azurerm_resource_group.rg_aks_01.name
  public_ip_01_name                = "ip-publica-aks-01"
  default_node_pool_name           = "agentpool"
  default_node_pool_node_count     = 2
  default_node_pool_vm_size        = "Standard_D2_v2"
  default_node_pool_vnet_subnet_id = azurerm_subnet.subnet_02.id
}