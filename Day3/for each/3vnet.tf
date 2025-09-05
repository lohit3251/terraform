resource "azurerm_virtual_network" "lohitvnet" {

    for_each = {
    lohitvn1 = { rg = "rg1", address_space = "10.0.0.0/16" }
    lohitvn2 = { rg = "rg1", address_space = "10.0.1.0/16" }
    lohitvn3 = { rg = "rg1", address_space = "10.0.2.0/16" }

    # RG2 VNets
    lohitvn4 = { rg = "rg2", address_space = "10.1.0.0/16" }
    lohitvn5 = { rg = "rg2", address_space = "10.1.1.0/16" }
    lohitvn6 = { rg = "rg2", address_space = "10.1.2.0/16" }

    # RG3 VNets
    lohitvn7 = { rg = "rg3", address_space = "10.2.0.0/16" }
    lohitvn8 = { rg = "rg3", address_space = "10.2.1.0/16" }
    lohitvn9 = { rg = "rg3", address_space = "10.2.2.0/16" }
  }

  name                = each.key
  address_space       = [each.value.address_space]
  location            = azurerm_resource_group.rg1[each.value.rg].location
  resource_group_name = azurerm_resource_group.rg1[each.value.rg].name
}
  
