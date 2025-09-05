resource "azurerm_subnet" "lohitsubnet" {
  for_each = {
    lohitsb1 = { rg = "rg1", lohitvn = "lohitvn1", address_prefixes = "10.0.1.0/24" }
    lohitsb2 = { rg = "rg2", lohitvn = "lohitvn2", address_prefixes = "10.0.2.0/24" }
    lohitsb3 = { rg = "rg3", lohitvn = "lohitvn3", address_prefixes = "10.0.3.0/24" }
  }

  name                 = each.key
  resource_group_name  = azurerm_resource_group.rg1[each.value.rg].name
  virtual_network_name = azurerm_virtual_network.lohitvnet[each.value.lohitvn].name
  address_prefixes     = [each.value.address_prefixes]
}

