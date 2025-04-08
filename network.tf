resource "azurerm_virtual_network" "nextcloud" {
  name                = local.vnet_name
  location            = azurerm_resource_group.nextcloud.location
  resource_group_name = azurerm_resource_group.nextcloud.name
  address_space       = var.vnet_addressspace
}

resource "azurerm_subnet" "nextcloud_pe" {
  name                            = "nextcloud_pe"
  resource_group_name             = azurerm_resource_group.nextcloud.name
  virtual_network_name            = azurerm_virtual_network.nextcloud.name
  address_prefixes                = [cidrsubnet(var.vnet_addressspace[0], 4, 1)]
  default_outbound_access_enabled = false
}

resource "azurerm_subnet" "nextcloud_asp" {
  name                            = "nextcloud_asp"
  resource_group_name             = azurerm_resource_group.nextcloud.name
  virtual_network_name            = azurerm_virtual_network.nextcloud.name
  address_prefixes                = [cidrsubnet(var.vnet_addressspace[0], 4, 2)]
  default_outbound_access_enabled = false

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}