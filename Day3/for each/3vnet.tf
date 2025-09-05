resource "azurerm_virtual_network" "lohitvnet" {

    for_each = {
    lohitvn1 = { rg = "rg1", address_space = "10.0.0.0/16" }
    lohitvn2 = { rg = "rg1", address_space = "10.0.1.0/16" }
    lohitvn3 = { rg = "rg1", address_space = "10.0.2.0/16" }

  }

  name                = each.key
  address_space       = [each.value.address_space]
  location            = azurerm_resource_group.rg1[each.value.rg].location
  resource_group_name = azurerm_resource_group.rg1[each.value.rg].name
}
  
