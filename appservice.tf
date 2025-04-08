resource "azurerm_service_plan" "nextcloud" {
  name                   = local.asp_name
  resource_group_name    = azurerm_resource_group.nextcloud.name
  location               = azurerm_resource_group.nextcloud.location
  os_type                = "Linux"
  sku_name               = "P0v3"
  worker_count           = 3
  zone_balancing_enabled = true
}