resource "azurerm_resource_group" "PythonDeployment11" {
  name     = "PythonDeployment11"
  location = "South India"
}
resource "azurerm_virtual_network" "V-net" {
  name                = "PythonDeployment11-V-net"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
}

resource "azurerm_subnet" "Mysubnet1" {
  name                 = "Mysubnet1"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "NIC" {
  name                = "NIC"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.Mysubnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_security_group" "linux-vm-nsg" {
  depends_on          = [azurerm_resource_group.network-rg]
  name                = "linux-vm-nsg"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  security_rule {
    name                       = "AllowHTTP"
    description                = "Allow HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowSSH"
    description                = "Allow SSH"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Allowcustome8000"
    description                = "Allow HTTP"
    priority                   = 90
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8000"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

resource "azurerm_linux_virtual_machine" "VM-PythonDeployment11" {
  name                = "VM-machine"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  admin_password      = "P@ssw0rd@123"
  #custom_data    = base64encode(data.template_filescript.sh.rendered)
  network_interface_ids = [
    azurerm_network_interface.NIC.id,
  ]
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "SKU for RHEL 8.5 Gen2"
    version   = "latest"
  }
  os_disk {
    name                 = "linux-vm-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
