terraform {
  backend "azurerm" {
    resource_group_name = "Backend"
    storage_account_name = "lohitstorageaccount"
    container_name = "terraformtfstate"
    key="terraform.tfstate"
    
  }
}