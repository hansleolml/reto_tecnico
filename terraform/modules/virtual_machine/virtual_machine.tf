resource "azurerm_network_interface" "nic_01" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vmachine_01" {
  name                = var.vm_name
  resource_group_name = azurerm_network_interface.nic_01.resource_group_name
  location            = azurerm_network_interface.nic_01.location
  size                = var.vm_size
  admin_username      = var.vm_admin
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