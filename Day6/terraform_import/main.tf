terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.42.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "a7b5f759-c5f6-4658-b6e3-285cf8e2dfb4"
  # Configuration options
}

resource "azurerm_resource_group" "rg" {
  name     = "lohitrg"
  location = "canadacentral"

}

resource "azurerm_virtual_network" "vnet1" {
  name                = "lohitvirtualnetwork"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

