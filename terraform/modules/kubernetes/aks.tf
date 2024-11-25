/*
resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_01_name
  resource_group_name = var.rg_aks_01_name
  location            = var.location_aks
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "lb" {
  name                = var.load_balancer_name
  location            = azurerm_public_ip.public_ip.location
  resource_group_name = azurerm_public_ip.public_ip.resource_group_name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "frontendConfig"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}*/

resource "azurerm_kubernetes_cluster" "aks_01" {
  name                 = var.aks_01_name
  location             = var.location_aks
  resource_group_name  = var.rg_aks_01_name
  dns_prefix           = var.aks_01_dns_prefix
  azure_policy_enabled = "true"
  sku_tier             = "Free"
  kubernetes_version   = var.aks_01_version

  network_profile {
    network_plugin = "azure"
    #network_plugin_mode = "subnet"
    network_policy    = "azure"
    load_balancer_sku = "standard"
    #load_balancer_profile {
    #  outbound_ip_address_ids = [azurerm_public_ip.public_ip.id] 
    #}
  }

  default_node_pool {
    name       = var.default_node_pool_name
    node_count = var.default_node_pool_node_count
    #min_count      = var.default_node_pool_min_count
    #max_count      = var.default_node_pool_max_count
    vm_size        = var.default_node_pool_vm_size
    vnet_subnet_id = var.default_node_pool_vnet_subnet_id
    upgrade_settings {
      drain_timeout_in_minutes = 0
      max_surge = "10%"
      node_soak_duration_in_minutes = 0
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
    Environment2 = "challenge"
  }
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks_01.kube_config_raw

  sensitive = true
}