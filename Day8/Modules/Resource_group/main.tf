




module "resource_group" {
    source = "git::https://github.com/bkrrajmali/terraform-morning-azure-modules.git//modules/resource_group?ref=prod"
    name     = var.name
    location = var.location
  
}



