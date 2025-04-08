resource "azurerm_redis_cache" "nextcloud" {
  name                = local.redis_name
  location            = azurerm_resource_group.nextcloud.location
  resource_group_name = azurerm_resource_group.nextcloud.name

  capacity = 1
  family   = "C"
  sku_name = "Standard"

  non_ssl_port_enabled               = false
  minimum_tls_version                = "1.2"
  public_network_access_enabled      = false
  access_keys_authentication_enabled = true

}

resource "azurerm_private_endpoint" "nextcloud_redis" {
  name                = local.redis_pe_name
  location            = azurerm_resource_group.nextcloud.location
  resource_group_name = azurerm_resource_group.nextcloud.name
  subnet_id           = azurerm_subnet.nextcloud_pe.id

  private_service_connection {
    name                           = azurerm_redis_cache.nextcloud.name
    private_connection_resource_id = azurerm_redis_cache.nextcloud.id
    is_manual_connection           = false
    subresource_names              = ["redisCache"]
  }

  private_dns_zone_group {
    name                 = azurerm_redis_cache.nextcloud.name
    private_dns_zone_ids = [azurerm_private_dns_zone.redis.id]
  }
}