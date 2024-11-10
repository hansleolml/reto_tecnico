resource "azurerm_network_interface" "nic_01" {
  name                = var.nic_name
  location            = azurerm_public_ip.ip_public_01.location
  resource_group_name = azurerm_public_ip.ip_public_01.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip_public_01.id
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg_01" {
  network_interface_id      = azurerm_network_interface.nic_01.id
  network_security_group_id = var.nsg_01_id
}

resource "azurerm_public_ip" "ip_public_01" {
  name                = var.ip_public_01_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"

}

resource "azurerm_linux_virtual_machine" "vmachine_01" {
  name                = var.vm_name
  resource_group_name = azurerm_network_interface.nic_01.resource_group_name
  location            = azurerm_network_interface.nic_01.location
  size                = var.vm_size
  admin_username      = var.vm_admin
  custom_data         = filebase64("./modules/virtual_machine/script-jenkins.sh")
  network_interface_ids = [
    azurerm_network_interface.nic_01.id,
  ]

  admin_ssh_key {
    username   = var.vm_admin
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = var.vm_sku
    version   = "latest"
  }
}