resource "azurerm_private_dns_zone" "redis" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = azurerm_resource_group.nextcloud.name
}

resource "azurerm_private_dns_zone" "file_storage" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = azurerm_resource_group.nextcloud.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "redis" {
  name                  = "pe_redis"
  resource_group_name   = azurerm_resource_group.nextcloud.name
  private_dns_zone_name = azurerm_private_dns_zone.redis.name
  virtual_network_id    = azurerm_virtual_network.nextcloud.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "file_storage" {
  name                  = "pe_file_storage"
  resource_group_name   = azurerm_resource_group.nextcloud.name
  private_dns_zone_name = azurerm_private_dns_zone.file_storage.name
  virtual_network_id    = azurerm_virtual_network.nextcloud.id
}