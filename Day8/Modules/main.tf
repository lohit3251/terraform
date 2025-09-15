module "rg1" {

  source   = "git::https://github.com/bkrrajmali/terraform-morning-azure-modules.git//modules/resource_group?ref=prod"
  name     = var.rg_name
  location = var.location

}

module "network" {

  source = "git::https://github.com/bkrrajmali/terraform-morning-azure-modules.git//modules/network?ref=prod"

  rg_name  = module.rg1.name
  location = module.rg1.location

  vnet_name     = var.vnet_name
  address_space = var.address_space
  subnet_name   = var.subnet_name
  subnet_prefix = var.subnet_prefix
}

module "PIP" {

  source = "git::https://github.com/bkrrajmali/terraform-morning-azure-modules.git//modules/public_ip?ref=prod"

  count    = var.enabled ? 1 : 0
  enabled  = true
  name     = var.pip_name
  location = module.rg1.location
  rg_name  = module.rg1.name

  sku  = var.sku
  tags = var.tags

}

module "nic" {

  source = "git::https://github.com/bkrrajmali/terraform-morning-azure-modules.git//modules/nic?ref=prod"

  name                  = var.nic_name
  location              = module.rg1.location
  rg_name               = module.rg1.name
  subnet_id             = module.network.subnet_id
  public_ip_id          = module.PIP[0].public_ip_id
  private_ip_allocation = "Dynamic"
  tags                  = var.tags

}

module "vm" {

  source = "git::https://github.com/bkrrajmali/terraform-morning-azure-modules.git//modules/vm_linux?ref=prod"

  name     = var.vm_name
  location = module.rg1.location
  rg_name  = module.rg1.name
  size     = var.vm_size
  nic_ids  = [module.nic.nic_id]
  tags     = var.tags

  admin_username = var.admin_username
  //disable_password_authentication = false
  admin_password = var.admin_password

  image = {
    publisher = var.image.publisher
    offer     = var.image.offer
    sku       = var.image.sku
    version   = var.image.version
  }

  os_disk = {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
    disk_size_gb         = var.os_disk.disk_size_gb
  }



}

