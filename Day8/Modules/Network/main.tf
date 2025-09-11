
module "network" {
    source="git::https://github.com/bkrrajmali/terraform-morning-azure-modules.git//modules/network?ref=prod"
    
  

  vnetname            = var.vnet_name
  location            = var.location
  resource_group_name = var.name
  address_space       = [var.address_space]
  subnet_name         = var.subnet_name  
  address_prefixes    = [var.subnet_prefix]
}





