rg_name  = "lohitrg"
location = "canadacentral"

vnet_name     = "lohitvnet"
address_space = ["10.0.0.0/16"]
subnet_name   = "lohitsubnet"
subnet_prefix = ["10.0.1.0/24"]

enabled = true

pip_name = "lohitpip"
sku      = "Standard"
tags = {
  environment = "dev"
  owner       = "lohit"
  project     = "terraform-demo"
}

nic_name              = "lohit-nic"
private_ip_allocation = "Dynamic"



 vm_name ="lohitvm"
 vm_size ="Standard_B1s"
 
 admin_username ="admin"
 admin_password ="Lohit@123456"
 image ={
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
 os_disk ={
      caching              = "ReadWrite"
  storage_account_type = "Standard_LRS"
  disk_size_gb         = 30
  
  }




