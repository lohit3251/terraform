output "name"     {
   value = module.rg1.name 
   }
output "location" { 
  value = module.rg1.location 
  }




output "nic_id" {
  description = "The ID of the network interface."
  value       = module.nic.nic_id
}







output "public_ip_id" {
  description = "The ID of the public IP."
  value       = module.PIP[0].public_ip_id
}


output "vm_id" {
  description = "The ID of the virtual machine."
  value       = module.vm.id
}
