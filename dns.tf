resource "azurerm_private_dns_zone" "blob_storage" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.nextcloud.name
}

resource "azurerm_private_dns_zone" "file_storage" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = azurerm_resource_group.nextcloud.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_storage" {
  name                  = "pe_blob_storage"
  resource_group_name   = azurerm_resource_group.nextcloud.name
  private_dns_zone_name = azurerm_private_dns_zone.blob_storage.name
  virtual_network_id    = azurerm_virtual_network.nextcloud.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "file_storage" {
  name                  = "pe_file_storage"
  resource_group_name   = azurerm_resource_group.nextcloud.name
  private_dns_zone_name = azurerm_private_dns_zone.file_storage.name
  virtual_network_id    = azurerm_virtual_network.nextcloud.id
}