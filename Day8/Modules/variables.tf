variable "rg_name" {}
variable "location" {}

variable "vnet_name" {}
variable "address_space" {}
variable "subnet_name" {}
variable "subnet_prefix" {}

variable "enabled" {}

variable "pip_name" {}
variable "sku" {}
variable "tags" {}



variable "nic_name" {}

variable "private_ip_allocation" {}


variable "vm_name" {}
variable "vm_size" {}

variable "admin_username" {}
variable "admin_password" {}
variable "image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
    disk_size_gb         = number
  })
  }

 







