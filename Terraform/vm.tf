resource "azurerm_public_ip" "vm_ip" {
  name = "vm-ip"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method = "Static"
  sku = "Standard"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_interface" "nic" {
  name = "vm-nic"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.subnet.id
    public_ip_address_id = azurerm_public_ip.vm_ip.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = {
    environment = var.environment
  }
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "azurerm_linux_virtual_machine" "vm" {
  name = "vm-caso2"
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  size = var.vm_size 
  admin_username = var.vm_admin_user

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]
  admin_ssh_key {
    username = var.vm_admin_user
    public_key = tls_private_key.ssh_key.public_key_openssh
  }
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  tags = {
    environment = var.environment
  }
}