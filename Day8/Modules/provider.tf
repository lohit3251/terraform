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