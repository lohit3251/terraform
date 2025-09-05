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
  name     = "gatta-897"
  location = "canadacentral"
 tags = {
   project="sample"
   owner="admin"
   env="prod"
 }
 lifecycle {
   ignore_changes = [ tags ]
 }

}

resource "azurerm_virtual_network" "vnet1" {
  name                = "lohitvnet1"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.0.0.0/16"]
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_subnet" "subnet1" {
  name                 = "lohit-subnet123"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.2.0/24"]
  lifecycle {
    create_before_destroy = true
  }


}
resource "azurerm_network_security_group" "nsg1" {
  name                = "lohitSecurityGroup1"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  depends_on = [ azurerm_subnet.subnet1 ]
}



