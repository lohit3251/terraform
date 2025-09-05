terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.42.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "a7b5f759-c5f6-4658-b6e3-285cf8e2dfb4"
  # Configuration options
}

# resource "random_string" "name" {
#   length = 6
#   upper = false
#   special =false  
# }

# resource "azurerm_resource_group" "rg1" {
#   name     = "gatta-897-${random_string.name.id}"
#   location = "canadacentral"
# }

resource "azurerm_resource_group" "rg1" {
  name     = "gatta-897"
  location = "canadacentral"
}