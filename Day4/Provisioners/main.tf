terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.42.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "a7b5f759-c5f6-4658-b6e3-285cf8e2dfb4"
  # Configuration options
}


resource "azurerm_resource_group" "rg1" {
  name     = "gatta-6897"
  location = "canadacentral"

}

resource "azurerm_virtual_network" "vnet1" {
  name                = "lohitvnet1"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "lohit-subnet"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]

}

resource "azurerm_public_ip" "pip1" {
  name                = "lohitpip1"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  allocation_method   = "Static"


}

resource "azurerm_network_interface" "nic1" {
  name                = "lohit-nic"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "lohitpip1"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip1.id
  }

}

resource "azurerm_network_security_group" "nsg1" {
  name                = "lohitSecurityGroup1"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name



  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }
}

resource "azurerm_subnet_network_security_group_association" "nsgassociation" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id

}

resource "azurerm_linux_virtual_machine" "vm1" {
  name                  = "lohit-vm"
  location              = azurerm_resource_group.rg1.location
  resource_group_name   = azurerm_resource_group.rg1.name
  network_interface_ids = [azurerm_network_interface.nic1.id]
  size                  = "Standard_B1s"
  admin_username        = "azureadmin"

  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureadmin"
    public_key = file("C:\\Users\\lohitkumar.gatta\\Downloads\\lohitkeys\\mykey_openssh.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "null_resource" "local" {
  provisioner "local-exec" {
    command = "echo ${azurerm_public_ip.pip1.ip_address} >> public_ip.txt"

  }
}

resource "null_resource" "copyfile" {

  provisioner "file" {
    source      = "install_apache.sh"
    destination = "/tmp/install_apache.sh"
    connection {
      type        = "ssh"
      host        = azurerm_public_ip.pip1.ip_address
      user        = "azureadmin"
      private_key = file("C:\\Users\\lohitkumar.gatta\\Downloads\\lohitkeys\\mykey_openssh")
    }

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_apache.sh",
      "sudo /tmp/install_apache.sh"
    ]
    connection {
      type        = "ssh"
      host        = azurerm_public_ip.pip1.ip_address
      user        = "azureadmin"
      private_key = file("C:\\Users\\lohitkumar.gatta\\Downloads\\lohitkeys\\mykey_openssh")
      
    }

  }

}












